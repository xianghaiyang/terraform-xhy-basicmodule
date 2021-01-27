
variable "use_nat_module" {}

variable "delete_protection" {}

variable "vpc_id" {}

variable "specification" {}

variable "name" {}

variable "vswitch_id" {}   # 这是nat实例创建需要的交换机

variable "snat_vswitch_id" {}

variable "snat_entry_name" {}





# ============eip==========

variable "eip_count" {}

variable "eip_name" {}

variable "count_format" {}

variable "bandwidth" {}

variable "eip_internet_charge_type" {}

variable "isp" {}

variable "eip_instance_charge_type" {}

variable "tags" {}




