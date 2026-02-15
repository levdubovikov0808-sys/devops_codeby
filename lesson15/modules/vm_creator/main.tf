# Выбираем subnet_id по зоне
locals {
  subnet_id = lookup(var.subnet_map, var.availability_zone, "")
}

resource "openstack_networking_port_v2" "instance_port" {
  name               = "${var.instance_name}-port"
  network_id         = var.network_id
  security_group_ids = var.security_group_ids

  fixed_ip {
    subnet_id = local.subnet_id
  }
}

resource "openstack_blockstorage_volume_v3" "boot_volume" {
  name                 = "${var.instance_name}-boot"
  size                 = var.volume_size
  image_id             = var.image_id
  volume_type          = var.volume_type
  availability_zone    = var.availability_zone
  enable_online_resize = true
}

resource "openstack_compute_instance_v2" "instance" {
  name              = var.instance_name
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair_name
  availability_zone = var.availability_zone

  network {
    port = openstack_networking_port_v2.instance_port.id
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.boot_volume.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }
}

# Плавающий IP (опционально)
resource "openstack_networking_floatingip_v2" "fip" {
  count = var.assign_floating_ip ? 1 : 0
  pool  = "external-network"
}

resource "openstack_networking_floatingip_associate_v2" "fip" {
  count       = var.assign_floating_ip ? 1 : 0
  port_id     = openstack_networking_port_v2.instance_port.id
  floating_ip = openstack_networking_floatingip_v2.fip[0].address
}
