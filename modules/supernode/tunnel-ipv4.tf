
resource "netbox_available_prefix" "tunnel_ipv4" {
  description      = "Tunnel ${var.name}/${each.key}"
  prefix_length    = 31
  status           = "reserved"
  parent_prefix_id = var.tunnel_prefix_ipv4_id
  is_pool          = true

  for_each = var.core_router_names

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}

resource "netbox_available_ip_address" "tunnel_ipv4" {
  prefix_id    = netbox_available_prefix.tunnel_ipv4[each.key].id
  interface_id = netbox_interface.tunnel[each.key].id

  status = "reserved"

  for_each = var.core_router_names

  tags = toset(var.tags)

  depends_on = [
    netbox_available_ip_address.tunnel_peer_ipv4,
  ]

  lifecycle {
    ignore_changes = [
      interface_id,
      status,
    ]
  }
}

resource "netbox_available_ip_address" "tunnel_peer_ipv4" {
  prefix_id = each.value.id

  status = "reserved"

  for_each = netbox_available_prefix.tunnel_ipv4

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      interface_id,
      status,
    ]
  }
}
