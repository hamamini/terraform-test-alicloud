# common variables
variable "alicloud_access_key" {}
variable "alicloud_secret_key" {}
variable "region" {
  default = "eu-central-1"
}
variable "availability_zone" {
  default = "eu-central-1a"
}
variable "vpc_name" {
  default = "test"
}
variable "vpc_cidr_block" {
	default = "10.1.0.0/16"
}
variable "vswitch_name" {
  default = "test"
}
variable "vswitch_cidr_block" {
	default = "10.1.0.0/16"
}
variable "security_group_name" {
	default = "terraform-test-group"
}
variable "nic_type" {
  default = "intranet"
}
variable "image_id" {
	default = "debian_8_09_64_20G_alibase_20170824.vhd"
}
variable "instance_type" {
	default = "ecs.xn4.small"
}
variable "number_of_instances" {
	default     = "1"
}
variable "system_disk_category" {
	default     = "cloud_efficiency"
}
variable "internet_max_bandwidth_out" {
	default     = "100"
}
variable "instance_name" {
	default     = "test"
}
variable "host_name" {
	default     = "testest"
}
variable "system_disk_size" {
	default     = "40"
}
variable "instance_password" {
	default     = "Hamed1215"
}
variable "private_ip" {
	default     = "10.1.0.69"
}
variable "number_format" {
  default = "%02d"
}
variable "path_to_private_key" {
  default = "/Users/hamed/.ssh/id_rsa"
}
variable "path_to_public_key" {
  default = "/Users/hamed/.ssh/id_rsa.pub"
}
variable "instance_username" {
  default = "hamed"
}