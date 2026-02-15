output "selected_subnet_map" {
  value = module.subnet_data.subnet_map
}

output "instance_id" {
  value = module.vm_creator.instance_id
}

output "instance_name" {
  value = module.vm_creator.instance_name
}

output "floating_ip" {
  value = module.vm_creator.floating_ip
}
