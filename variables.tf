#Main
variable "region" {
  default= ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = "default"
}

#resource management

variable "delete_protection" {
  default = "false"
}


variable "use_vpc_module" {
  default = false
}

variable "use_ecs_module" {
  default = false
}

variable "use_eip_module" {
  default = false
}

variable "use_slb_module" {
  default = false
}

variable "use_mongo_module" {
  default = false
}

variable "use_mq_module" {
  default = false
}

variable "use_rds_module" {
  default = false
}

variable "use_nat_module" {
  default = false
}

variable "use_redis_module" {
  default = false
}

variable "ecs_count" {
  default = 2
}

variable "eip_count" {
  default = 1
}

variable "mongo_count" {
  default = 1
}

variable "mqtopic_count" {
  default = 2
}

variable "rds_database_count" {
  default = 2
}

variable "redis_count" {
  default = "1"
}

variable "count_format" {
  default = "%02d"
}






# ====================VPC==================
# 这特么是交换机的可用区，vpc没有可用区的说法哦
variable "availability_zones" {
  type = "map"
  default = {
    check0 = "cn-chengdu-a"
    check1 = "cn-chengdu-b"
  }
}
# vpc网段
variable "vpc_cidr_blocks" {
  default = "172.16.0.0/12"
}

# 交换机网段
variable "vswitch_cidr_blocks" {
  type = "map"
  default = {
    check0 = "172.16.2.0/24"
    check1 = "172.16.1.0/24"

  }
}

variable "vpc_name" {
  default = "xhy_sfasdftest"
}

variable "vswitch_name" {
  default = "xhy_sfasdftest"
}


# =====================SLB=====================
variable "slb_name" {
  default = "xhy_safasfastest"
}

//variable "master_zone_id" {
//  default = "cn-chengdu-a"
//}
//
//variable "slave_zone_id" {
//  default = "cn-chengdu-b"
//}

variable "slb_vswitch_id" {
  default = ""
}

variable "address_type" {
  default = "intranet"
}

variable "specification" {
  default = "slb.s2.small"
}

variable "internet_charge_type" {
  default = "PayByTraffic"
}

variable "tags" {
  type = "map"
  default = {
    name   = "sdfasf"
    team  = "devopssafafsaf"
    forwhat = "safasdfsafas"

  }
}



# =========================ECS=========================
variable "image_owners" {
  default = "system"
}

variable "image_name" {
  default = "^centos_7_06_64"
}

variable "ecs_vswitch_id" {
  default = ""
}

variable "ecs_name" {
  default = "xhsdfasfdy_test"
}

variable "ecs_type" {
  default = "ecs.ic5.large"
}

variable "key_name" {
  default = "xhsdzsfzsy_test"
}

variable "ecs_internet_charge_type" {
  default = "PayByTraffic"
}


variable "ecs_instance_charge_type" {
  default = "PostPaid"
}

variable "internet_max_bandwidth_out" {
  default = 0
}

variable "system_disk_category" {
  default = "cloud_efficiency"
}

variable "disk_size" {
  default = "0"
}

variable "system_disk_size" {
  default = "40"
}

variable "security_group_name" {
  default = "xhfsfday"
}

variable "nic_type" {
  default = "intranet"
}

# ==============mongodb===============
variable "mongo_name" {
  default = "xhy_test"
}

variable "mongo_instance_class" {
  default = "dds.mongo.mid"
}

variable "mongo_instance_storage" {
  default = "10"
}

variable "mongo_replication_factor" {
  default = "3"
}

variable "mongo_instance_charge_type" {
  default = "PostPaid"
}

variable "mongo_vswitch_id" {
  default = ""
}

variable "mongo_account_password" {
  default = "Xhy18473962265"
}

variable "mongo_engine_version" {
  default = "4.2"
}


# ==============rocketMQ===============

variable "instance_name" {
  default = "xhy_test"
}

variable "group_name" {
  default = "xhy_test"
}

variable "topic_name" {
  default = "xhy_test"
}

variable "instance_description" {
  default = "xhy_instance_description"
}

variable "group_description" {
  default = "xhy_group_description"
}

variable "topic_description" {
  default = "xhy_topic_description"
}

variable "group_type" {
  default = ["tcp", "http"]
}

variable "topic_message_type" {
  type         = number
  description  = "这是topic接受的消息类型，可选0：普通消息 1：分区顺序消息 2：全局顺序消息 4：事务消息 5：定时/延时消息"
  default      = 0
}


# ==============rds===============

variable "rds_instance_name" {
  default = "xhy_test"
}

variable "rds_engine" {
  default = "MySQL"
}

variable "rds_engine_version" {
  default = "5.7"
}

variable "rds_instance_type" {
  default = "rds.mysql.t1.small"
}

variable "rds_instance_storage" {
  default = 20
}

variable "rds_instance_storage_type" {
  default = "local_ssd"
}

variable "rds_vswitch_id" {
  default = ""
}

variable "rds_account_name" {
  default = "test123"
}

variable "rds_account_password" {
  default = "test123"
}

variable "database_name" {
  default = "test_database_name"
}

variable "character_set" {
  default = "utf8"
}


# ==============natgateway=====EIP===========

variable "nat_name" {
  default = "xhy_test"
}

variable "snat_entry_name" {
  default = "xhy_test"
}

variable "nat_vswitch_id" {
  default = ""
}

variable "snat_vswitch_id" {
  default = ""
}

variable "nat_specification" {
  default = "Small"
}

# ================================================

variable "eip_name" {
  default = "xhy_test"
}

variable "eip_internet_charge_type" {
  default = "PayByTraffic"
}

variable "bandwidth" {
  default = "2"
  description = "eip的宽带大小"
}

variable "isp" {
  default = "BGP"
}

variable "eip_instance_charge_type" {
  default = "PostPaid"
}


# ========================redis===========================

variable "redis_instance_name" {
  default = "xhy_test"
}

variable "account_privilege" {
  default = "RoleReadWrite"
}

variable "redis_engine_version" {
  default = "4.0"
  description = "2.8, 4.0 and 5.0. Default to 5.0"
}

variable "redis_charge_type" {
  default = "PostPaid"
}

variable "redis_instance_class" {
  default = "redis.master.small.default"
}

variable "redis_instance_type" {
  default = "Redis"
}

variable "redis_vswitch_id" {
  default = ""
}

variable "backup_period" {
  default = "Saturday"
}

# 可
variable "redis_account_name" {
  default = "xhy_test"
}
variable "redis_account_password" {
  default = "test_123"
  description = "It may consist of letters, digits, or underlines, with a length of 6 to 32 characters"
}

variable "redis_backup_period" {
  default = ["Saturday", "Sunday"]
}

variable "redis_backup_time" {
  default = "18:00Z-19:00Z"
}