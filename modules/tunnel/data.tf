data "netbox_prefix" "ipv4" {
  cidr = var.tunnel_prefix_ipv4
}

data "netbox_prefix" "ipv6" {
  cidr = var.tunnel_prefix_ipv6
}
