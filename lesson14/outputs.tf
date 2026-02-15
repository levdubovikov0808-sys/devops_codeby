output "public_instance_floating_ip" {
  value = openstack_networking_floatingip_v2.public.address
}

output "private_instance_floating_ip" {
  value = openstack_networking_floatingip_v2.private.address
}
