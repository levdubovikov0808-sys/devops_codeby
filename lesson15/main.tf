terraform {
  required_version = ">= 1.3"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 2.1.0"
    }
  }
}

provider "openstack" {
  auth_url    = var.auth_url
  domain_name = var.domain_name
  tenant_id   = var.tenant_id
  user_name   = var.user_name
  password    = var.password
  region      = var.region
}

data "openstack_images_image_v2" "selected" {
  name        = var.image_name
  most_recent = true
  visibility  = "public"
}

module "subnet_data" {
  source = "./modules/subnet_data"

  network_id           = var.network_id
  region               = var.region
  zone_to_subnet_name  = var.zone_to_subnet_name
}

module "vm_creator" {
  source = "./modules/vm_creator"

  instance_name       = var.instance_name
  flavor_id           = var.flavor_id
  image_id            = data.openstack_images_image_v2.selected.id
  key_pair_name       = var.key_pair_name
  network_id          = var.network_id
  availability_zone   = var.target_zone
  subnet_map          = module.subnet_data.subnet_map
  security_group_ids  = var.security_group_ids
  assign_floating_ip  = var.assign_floating_ip
}
