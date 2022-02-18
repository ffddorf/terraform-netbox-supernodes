resource "netbox_available_prefix" "ipv4" {
  description      = "Supernode IPv4 addresses"
  prefix_length    = 29
  status           = "active"
  parent_prefix_id = data.netbox_prefix.ipv4.id
  is_pool          = true
}

resource "netbox_available_prefix" "ipv6" {
  description      = "Supernode IPv6 addresses"
  prefix_length    = 56
  status           = "active"
  parent_prefix_id = data.netbox_prefix.ipv6.id
}
