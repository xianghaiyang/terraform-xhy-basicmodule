output "instance_ids" {
  value = "${alicloud_kvstore_instance.default.*.id}"
}

# 输出redis的连接地址
output "connection_domain" {
  value = "${alicloud_kvstore_instance.default.*.connection_domain}"
}