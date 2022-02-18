data "netbox_prefix" "ipv4" {
  cidr = var.prefix_ipv4
}

data "netbox_prefix" "ipv6" {
  cidr = var.prefix_ipv6
}
