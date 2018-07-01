# common variables
variable "alicloud_access_key" {
  default = ""
}
variable "alicloud_secret_key" {
  default = ""
}
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
variable "image_id" {
	default = "debian_9_02_64_20G_alibase_20171023.vhd"
}
variable "instance_type" {
	default = "ecs.xn4.small"
}
variable "number_of_instances" {
	default     = "2"
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
	default     = "123456"
}
variable "private_ip" {
	default     = "10.1.0.69"
}
variable "number_format" {
  default = "%02d"
}