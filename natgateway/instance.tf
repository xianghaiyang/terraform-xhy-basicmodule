

# nat网关实现出网，入网建议使用slb
resource "alicloud_nat_gateway" "nat" {
  count                = var.use_nat_module ? 1 : 0
  vpc_id               = var.vpc_id                    # 这个破东西需要vpc
  specification        = "Small"            # 规格大小，Small、Middle、Large
  name                 = var.name
  instance_charge_type = "PostPaid"                    #
  vswitch_id           = element(distinct(compact(concat(var.vswitch_id))), 0)  # 新型的网关就有交换机这个东东
  nat_type             = "Enhanced"                    # 网关类型
}

resource "alicloud_eip" "eip" {
  count                 = "${var.use_nat_module ? (var.eip_count != 0 ? var.eip_count : (var.delete_protection ? 1 : 0)) : 0}"
  name                  = "${var.eip_name}-${format(var.count_format, count.index+1)}"
  bandwidth             = "${var.bandwidth}"                           # 宽带值 Mbps
  internet_charge_type  = "${var.eip_internet_charge_type}"            # PayByTraffic
  isp                   = "${var.isp}"                                 # BGP
  instance_charge_type  = "${var.eip_instance_charge_type}"            # PostPaid
  tags                  = "${var.tags}"                                # tags
//  vswitch_id            = element(distinct(compact(concat(var.vswitch_ids))), 0)
}

# 一个nat_getway资源绑定多个eip
resource "alicloud_eip_association" "eip_asso" {
  count                 = "${var.use_nat_module ? (var.eip_count != 0 ? var.eip_count : (var.delete_protection ? 1 : 0)) :0}"
  # 支持输入NAT网关实例ID、负载均衡SLB实例ID、云服务器ECS实例ID、
  #  辅助弹性网卡实例ID、高可用虚拟IP实例ID
//  instance_id           = element(distinct(compact(concat(var.instance_id))), count.index)
  instance_id           = alicloud_nat_gateway.nat.0.id
  allocation_id         = element(distinct(compact(concat(alicloud_eip.eip.*.id))), count.index)
}


# 出网()
resource "alicloud_snat_entry" "this_snat_entry" {
  # 几个交换机，就建立几个，一个交换机一个eip
  count             = "${var.use_nat_module ? (var.eip_count != 0 ? 1 : (var.delete_protection ? 1 : 0)) : 0}"
  snat_table_id     = alicloud_nat_gateway.nat.0.snat_table_ids      # natid
  snat_entry_name   = var.snat_entry_name                            #  命名
  source_vswitch_id = element(distinct(compact(concat(var.snat_vswitch_id))), 0)   # 该交换机s 下的主机将通过配置的公网ip(可通过eip变成多个)访问internet
  snat_ip           = element(distinct(compact(concat([alicloud_eip.eip.*.id]))), 0)                                  # 公网ip地址，[]
}










