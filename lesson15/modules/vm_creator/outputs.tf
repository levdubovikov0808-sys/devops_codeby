output "instance_id" {
  value = openstack_compute_instance_v2.instance.id
}

output "instance_name" {
  value = openstack_compute_instance_v2.instance.name
}

output "port_id" {
  value = openstack_networking_port_v2.instance_port.id
}

output "floating_ip" {
  value = var.assign_floating_ip ? openstack_networking_floatingip_v2.fip[0].address : null
}
