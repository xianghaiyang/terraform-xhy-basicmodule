# x = 5
# for i in range(10):
#     x = x + 1 if x < 10 else x -1
#     print(x)
#
#
# a = 1
# print('我今年%02d岁了' %a)
#
# # b = format("%02d", 1)
# # print(b)
#
# instance_name = "\'abc\'-format('%02d, 1)"
# print(instance_name)
#
# b = [1]
# print(a[1])

c = "a"
print(len(c))

#
# locals {
#   snat_with_vswitch_ids = flatten(
#     [
#       for _, obj in var.snat_with_vswitch_ids : [
#         for _, id in split(",", lookup(obj, "vswitch_ids", "")) : {
#           name              = lookup(obj, "name", "")
#           source_vswitch_id = id
#           snat_ip           = lookup(obj, "snat_ip", local.common_snat_ip)
#         }
#       ]
#     ]
#   )
# }


a = ["1, 2, 3"]

print(len(a))

