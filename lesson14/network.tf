# Приватная сеть (VPC)
resource "openstack_networking_network_v2" "vpc" {
  name           = "lesson14-network"
  admin_state_up = "true"
}

# Публичная подсеть (с выходом в интернет)
resource "openstack_networking_subnet_v2" "public" {
  name       = "public-subnet"
  network_id = openstack_networking_network_v2.vpc.id
  cidr       = "192.168.10.0/24"
  ip_version = 4
  dns_nameservers = ["8.8.8.8", "77.88.8.8"]
}

# Приватная подсеть (без шлюза по умолчанию, но будет подключена к роутеру)
resource "openstack_networking_subnet_v2" "private" {
  name       = "private-subnet"
  network_id = openstack_networking_network_v2.vpc.id
  cidr       = "192.168.20.0/24"
  ip_version = 4
  dns_nameservers = ["8.8.8.8", "77.88.8.8"]
  # gateway_ip = null  (по умолчанию не назначается)
}

# Внешняя сеть (для выхода в интернет и плавающих IP)
data "openstack_networking_network_v2" "external" {
  name = "external-network"
}

# Маршрутизатор
resource "openstack_networking_router_v2" "router" {
  name                = "lesson14-router"
  external_network_id = data.openstack_networking_network_v2.external.id
}

# Подключение публичной подсети к роутеру
resource "openstack_networking_router_interface_v2" "public" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.public.id
}

# Подключение приватной подсети к роутеру (ВАЖНО: теперь обе подсети имеют выход в интернет через NAT)
resource "openstack_networking_router_interface_v2" "private" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.private.id
}
