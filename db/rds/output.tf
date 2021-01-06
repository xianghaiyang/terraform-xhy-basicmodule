
output "rds_instance_id" {
  value = alicloud_db_instance.rds_instance.*.id
}

output "rds_instance_port" {
  value = alicloud_db_instance.rds_instance.*.port
}

output "rds_account_id" {
  value = alicloud_db_account.rds_account.*.id
}

output "rds_database_id" {
  value = alicloud_db_database.rds_database.*.id
}