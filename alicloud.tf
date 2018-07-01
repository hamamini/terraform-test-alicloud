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
}
