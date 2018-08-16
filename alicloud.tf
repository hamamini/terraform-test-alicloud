# Add Alicloud key pair
resource "alicloud_key_pair" "id_rsa" {
  key_name = "id_rsa"
  public_key = "${file("${var.path_to_public_key}")}"
}

# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${var.alicloud_access_key}"
  secret_key = "${var.alicloud_secret_key}"
  region     = "${var.region}"
}

# Create a virtual private network
resource "alicloud_vpc" "vpc-test" {
 name = "${var.vpc_name}"
 cidr_block = "${var.vpc_cidr_block}"
}

# Create a virtual subnet in the VPC
resource "alicloud_vswitch" "vswitch-test" {
 vpc_id = "${alicloud_vpc.vpc-test.id}"
 cidr_block = "${var.vswitch_cidr_block}"
 name = "${var.vswitch_name}"
 availability_zone = "${var.availability_zone}"
 depends_on = ["alicloud_vpc.vpc-test"]
}

# Create a security group in the VPC
resource "alicloud_security_group" "group-test" {
 name = "${var.security_group_name}"
 vpc_id = "${alicloud_vpc.vpc-test.id}"
}

# Open port range
resource "alicloud_security_group_rule" "allow_full_port" {
  type = "ingress"
  ip_protocol = "tcp"
  nic_type = "${var.nic_type}"
  policy = "accept"
  port_range = "${var.security_group_port_range}"
  priority = 1
  security_group_id = "${alicloud_security_group.group-test.id}"
  cidr_ip = "0.0.0.0/0"
}

# Create an ecs instance in the virtual subnet
resource "alicloud_instance" "instance-test" {
 image_id = "${var.image_id}"
 instance_type = "${var.instance_type}"
 availability_zone = "${var.availability_zone}"
 count = "${var.number_of_instances}"
 security_groups = ["${alicloud_security_group.group-test.id}"]
 vswitch_id = "${alicloud_vswitch.vswitch-test.id}"
 system_disk_category = "${var.system_disk_category}"
 private_ip = "${var.number_of_instances < 2 ? var.private_ip : ""}"
 internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"
 instance_name = "${var.number_of_instances < 2 ? var.instance_name : format("%s-%s", var.instance_name, format(var.number_format, count.index+1))}"
 host_name = "${var.number_of_instances < 2 ? var.host_name : format("%s-%s", var.host_name, format(var.number_format, count.index+1))}"
 system_disk_size = "${var.system_disk_size}"
 password= "${var.instance_password}"
 key_name = "${alicloud_key_pair.id_rsa.key_name}"


provisioner "file" {
	connection {
	    type = "ssh"
	    user = "root"
	    private_key = "${file("${var.path_to_private_key}")}"
	    #password = "${var.instance_password}"
	    agent = false
	    timeout = "2m"
	    host = "${self.public_ip}"
	  }

    source = "script.sh"
    destination = "/tmp/script.sh"
}
provisioner "remote-exec" {
	connection {
	    type = "ssh"
	    user = "root"
	    private_key = "${file("${var.path_to_private_key}")}"
	    agent = false
	    timeout = "2m"
	    host = "${self.public_ip}"
	  }
	inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
      "ls -lha /tmp/"
    ]
  }
}

# resource "alicloud_eip" "eip" {}

# resource "alicloud_eip_association" "eip_asso" {
#   allocation_id = "${alicloud_eip.eip.id}"
#   instance_id   = "${alicloud_instance.instance-test.id}"
# }

# data "template_file" "shell" {
#   template = "${file("script.sh")}"
# }
