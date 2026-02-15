# Загрузка публичного SSH-ключа
resource "openstack_compute_keypair_v2" "keypair" {
  name       = "lesson14-key"
  public_key = file(var.public_key_path)
}

# Поиск образа Ubuntu 22.04
data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu 22.04 LTS 64-bit"
  most_recent = true
  visibility  = "public"
}

# ------------------------------------------------------------
# Публичная ВМ
# ------------------------------------------------------------

# Порт для публичной ВМ
resource "openstack_networking_port_v2" "public" {
  name               = "public-instance-port"
  network_id         = openstack_networking_network_v2.vpc.id
  security_group_ids = [openstack_networking_secgroup_v2.public.id]

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.public.id
  }
}

# Загрузочный том
resource "openstack_blockstorage_volume_v3" "public_boot" {
  name                 = "public-boot-volume"
  size                 = 10
  image_id             = data.openstack_images_image_v2.ubuntu.id
  volume_type          = var.volume_type
  availability_zone    = var.availability_zone
  enable_online_resize = true
}

# Инстанс
resource "openstack_compute_instance_v2" "public" {
  name              = "public-instance"
  flavor_id         = var.flavor_id
  key_pair          = openstack_compute_keypair_v2.keypair.name
  availability_zone = var.availability_zone

  network {
    port = openstack_networking_port_v2.public.id
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.public_boot.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }
}

# Плавающий IP
resource "openstack_networking_floatingip_v2" "public" {
  pool = "external-network"
}

# Ассоциация плавающего IP
resource "openstack_networking_floatingip_associate_v2" "public" {
  port_id     = openstack_networking_port_v2.public.id
  floating_ip = openstack_networking_floatingip_v2.public.address
}

# Провижинер для публичной ВМ (выполняется после полного создания)
resource "null_resource" "public_provisioner" {
  depends_on = [
    openstack_compute_instance_v2.public,
    openstack_networking_floatingip_associate_v2.public
  ]

  connection {
    type        = "ssh"
    user        = "root"                     # изменено с ubuntu на root
    private_key = file(var.private_key_path)
    host        = openstack_networking_floatingip_v2.public.address
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to finish...'",
      "while ! sudo cloud-init status --wait 2>/dev/null; do echo 'still waiting...'; sleep 10; done",
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'Nginx installed on public instance'"
    ]
  }
}

# ------------------------------------------------------------
# Приватная ВМ
# ------------------------------------------------------------

# Порт для приватной ВМ
resource "openstack_networking_port_v2" "private" {
  name               = "private-instance-port"
  network_id         = openstack_networking_network_v2.vpc.id
  security_group_ids = [openstack_networking_secgroup_v2.private.id]

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.private.id
  }
}

# Загрузочный том
resource "openstack_blockstorage_volume_v3" "private_boot" {
  name                 = "private-boot-volume"
  size                 = 10
  image_id             = data.openstack_images_image_v2.ubuntu.id
  volume_type          = var.volume_type
  availability_zone    = var.availability_zone
  enable_online_resize = true
}

# Инстанс
resource "openstack_compute_instance_v2" "private" {
  name              = "private-instance"
  flavor_id         = var.flavor_id
  key_pair          = openstack_compute_keypair_v2.keypair.name
  availability_zone = var.availability_zone

  network {
    port = openstack_networking_port_v2.private.id
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.private_boot.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }
}

# Плавающий IP
resource "openstack_networking_floatingip_v2" "private" {
  pool = "external-network"
}

# Ассоциация плавающего IP
resource "openstack_networking_floatingip_associate_v2" "private" {
  port_id     = openstack_networking_port_v2.private.id
  floating_ip = openstack_networking_floatingip_v2.private.address
}

# Провижинер для приватной ВМ
resource "null_resource" "private_provisioner" {
  depends_on = [
    openstack_compute_instance_v2.private,
    openstack_networking_floatingip_associate_v2.private
  ]

  connection {
    type        = "ssh"
    user        = "root"                     # изменено с ubuntu на root
    private_key = file(var.private_key_path)
    host        = openstack_networking_floatingip_v2.private.address
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to finish...'",
      "while ! sudo cloud-init status --wait 2>/dev/null; do echo 'still waiting...'; sleep 10; done",
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'Nginx installed on private instance'"
    ]
  }
}
