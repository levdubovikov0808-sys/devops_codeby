# Security group для public ВМ
resource "openstack_networking_secgroup_v2" "public" {
  name        = "public-sg"
  description = "Allow SSH, HTTP, HTTPS"
}

resource "openstack_networking_secgroup_rule_v2" "public_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.public.id
}

resource "openstack_networking_secgroup_rule_v2" "public_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.public.id
}

resource "openstack_networking_secgroup_rule_v2" "public_https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.public.id
}

# Security group для private ВМ
resource "openstack_networking_secgroup_v2" "private" {
  name        = "private-sg"
  description = "Allow SSH, port 8080"
}

resource "openstack_networking_secgroup_rule_v2" "private_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.private.id
}

resource "openstack_networking_secgroup_rule_v2" "private_8080" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.private.id
}
