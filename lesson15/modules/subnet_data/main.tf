data "openstack_networking_subnet_ids_v2" "all" {
  network_id = var.network_id
}

data "openstack_networking_subnet_v2" "subnet" {
  count      = length(data.openstack_networking_subnet_ids_v2.all.ids)
  subnet_id  = data.openstack_networking_subnet_ids_v2.all.ids[count.index]
}

locals {
  all_subnets = data.openstack_networking_subnet_v2.subnet[*]
  name_to_id  = { for s in local.all_subnets : s.name => s.id }
  zone_to_id  = { for zone, name in var.zone_to_subnet_name : zone => local.name_to_id[name] }
}
