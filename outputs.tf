output "ecs_id" {
  value = "${alicloud_instance.instance-test.*.id}"
}

output "ecs_public_ip" {
  value = "${alicloud_instance.instance-test.*.public_ip}"
}

output "ecs_private_ip" {
  value = "${alicloud_instance.instance-test.*.private_ip}"
}