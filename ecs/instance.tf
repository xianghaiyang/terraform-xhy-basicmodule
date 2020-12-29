
resource "alicloud_security_group" "group" {
  count                 = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  name                  = "${var.security_group_name}"
  vpc_id                = "${var.vpc_id}"
  inner_access_policy   = "Accept"
  description           = "default security group"
  tags                  = "${var.tags}"

}

resource "alicloud_security_group_rule" "rdp" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "3389/3389"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ssh" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}


resource "alicloud_security_group_rule" "icmp" {
  count             = "${var.use_ecs_module ? (var.ecs_count != 0 ? 1 : (var.deletion_protection ? 1 : 0)) : 0}"
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "${var.nic_type}"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = "${alicloud_security_group.group.0.id}"
  cidr_ip           = "0.0.0.0/0"
}


data "alicloud_images" "images_ds" {
  owners     = "${var.image_owners}"
  name_regex = "${var.image_name}"
}



resource "alicloud_instance" "instance" {
  count = "${var.use_ecs_module ? var.ecs_count : (var.deletion_protection ? 1 : 0)}"
  instance_name = "${var.ecs_name}-${format(var.ecs_count_format, count.index+1)}"
  image_id = "${data.alicloud_images.images_ds.images.0.id}"
  instance_type = "${var.ecs_type}"
  security_groups = ["${alicloud_security_group.group.0.id}"]
//  availability_zone = "${var.availability_zones[count.index]}"    ###
//  availability_zone = element(distinct(compact(concat(var.availability_zones))), count.index)
  internet_charge_type = "${var.ecs_internet_charge_type}"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"
  instance_charge_type = "${var.ecs_instance_charge_type}"
  system_disk_category = "${var.disk_category}"
  system_disk_size = "${var.system_disk_size}"
//  vswitch_id = "${var.vswitch_ids[count.index]}"                  ###
  # 连接多个列表、去空、去重、下标count.index轮循
  vswitch_id = element(distinct(compact(concat(var.vswitch_ids))), 0)
//  vswitch_id = element(distinct(compact(concat([var.vswitch_id], var.vswitch_ids))), count.index, )
  tags = "${var.tags}"
  deletion_protection = "${var.deletion_protection}"
}
