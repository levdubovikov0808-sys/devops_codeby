resource "selectel_vpc_project_v2" "project" {
  name = var.project_name
}

resource "openstack_networking_network_v2" "network" {
  name           = "${var.project_name}-network"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${var.project_name}-subnet"
  network_id = openstack_networking_network_v2.network.id
  cidr       = "10.10.0.0/24"
  ip_version = 4
}
