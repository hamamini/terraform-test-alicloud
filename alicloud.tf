# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${var.alicloud_access_key}"
  secret_key = "${var.alicloud_secret_key}"
  region     = "${var.region}"
}

# Create a virtual private network
resource "alicloud_vpc" "vpc-test" {
 name = "test"
 cidr_block = "10.1.0.0/24"
}

# Create a virtual subnet in the VPC
resource "alicloud_vswitch" "vswitch-test" {
 vpc_id = "${alicloud_vpc.vpc-test.id}"
 cidr_block = "10.1.0.0/24"
 name = "test"
 availability_zone = "eu-central-1a"
 depends_on = ["alicloud_vpc.vpc-test"]
}

# Create a security group in the VPC
resource "alicloud_security_group" "group-test" {
 name = "terraform-test-group"
 description = "New security group"
 vpc_id = "${alicloud_vpc.vpc-test.id}"
}

# Create an ecs instance in the virtual subnet
resource "alicloud_instance" "instance-test" {
 image_id = "debian_9_02_64_20G_alibase_20171023.vhd"
 instance_type = "ecs.xn4.small"
 availability_zone = "${var.availability_zone}"
 count = "2"
 security_groups = ["${alicloud_security_group.group-test.id}"]
 vswitch_id = "${alicloud_vswitch.vswitch-test.id}"
 system_disk_category = "cloud_efficiency"
 private_ip = "10.1.0.69"
 internet_max_bandwidth_out = "100"
 instance_name = "test"
 host_name = "testest"
 system_disk_size = "60"
 password= ""
}
