
resource "alicloud_kvstore_instance" "default" {
  count                = "${var.use_redis_module ? (var.instance_count != 0 ? var.instance_count : (var.delete_protection ? 1 : 0)) : 0}"
  instance_name        = "${var.instance_name}-${format(var.count_format, count.index+1)}"              # 实例命名
  instance_charge_type = "${var.instance_charge_type}"       # 预付费，后付费
  instance_class       = "${var.instance_class}"             # 实例规格
  vswitch_id           = element(distinct(compact(concat(var.vswitch_ids))), 0)                 # 交换机id
  security_ips         = "${var.security_ips}"               # 白名单
  instance_type        = "${var.instance_type}"              # Redis or Memcache
  engine_version       = "${var.engine_version}"             # 数据库版本 有2.8、4.0、5.0
  tags                 = var.tags
}

resource "alicloud_kvstore_account" "account" {
  count           = "${var.use_redis_module ? (var.instance_count != 0 ? var.instance_count : (var.delete_protection ? 1 : 0)) : 0}"
  instance_id      = "${element(alicloud_kvstore_instance.default.*.id, count.index)}"   # 实例
  account_name     = "${var.instance_name}-${format(var.count_format, count.index+1)}"           # 数据库账户
  account_password = "${var.account_password}"       # 密码
  account_privilege = "${var.account_privilege}"     # 读写权限
}

resource "alicloud_kvstore_backup_policy" "default" {
  count         = "${var.use_redis_module ? 1 : 0}"
  instance_id   = "${element(alicloud_kvstore_instance.default.*.id, count.index)}"
  backup_period = "${var.backup_period}"                # Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday

}
