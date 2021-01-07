
resource "alicloud_db_instance" "rds_instance" {
  count  = var.use_rds_db ? (var.rds_database_count != 0 ? 1 : (var.delete_protection ? 1 : 0)) : 0
  engine  = var.engine                          # 数据库类型 MySQL, SQLServer, PostgreSQL, and PPAS
  engine_version  = var.engine_version          # 数据库版本https://www.alibabacloud.com/help/zh/doc-detail/26228.htm
  instance_type = var.instance_type             # 规格
  instance_storage = var.instance_storage       # 数据库大小 20以上你绝壁不会有BUG
  db_instance_storage_type = var.db_instance_storage_type # 储存类型，local_ssd、cloud_ssd、cloud_essd、cloud_essd2、cloud_essd3
  instance_name         = var.rds_name
  vswitch_id    = element(distinct(compact(concat(var.vswitch_ids))), 0)
  security_ips  = var.security_ips              # 白名单
  security_group_ids = var.security_group_ids   # 安全组
  tags = var.tags                               # 标签
}

resource "alicloud_db_account" "rds_account" {             # 创建数据库用户一样以及和用户对应的密码 root mysql
  count       = var.use_rds_db ? (var.rds_database_count != 0 ? 1 : (var.delete_protection ? 1 : 0)) : 0
  instance_id = alicloud_db_instance.rds_instance.0.id
  name        = var.account_name
  password    = var.rds_password
}

resource "alicloud_db_database" "rds_database" {
  count           = var.use_rds_db ? (var.rds_database_count != 0 ? var.rds_database_count : (var.delete_protection ? 1 : 0)) : 0
  instance_id     = alicloud_db_instance.rds_instance.0.id
  name            = "${var.database_name}-${format(var.count_format, count.index+1)}"
  character_set   = var.character_set
}











