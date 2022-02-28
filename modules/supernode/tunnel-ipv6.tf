resource "netbox_available_prefix" "tunnel_ipv6" {
  description      = "Tunnel ${var.name}/${each.key}"
  prefix_length    = 64
  status           = "reserved"
  parent_prefix_id = var.tunnel_prefix_ipv6_id
  is_pool          = true

  for_each = var.core_router_names

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}

resource "netbox_ip_address" "reserve_zero" {
  # we don't want to use the 0 address,
  # because of bugs in other tools

  ip_address = each.value.prefix
  status     = "reserved"

  for_each = netbox_available_prefix.tunnel_ipv6
  
  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "tunnel_ipv6" {
  prefix_id    = each.key
  interface_id = each.value

  status = "reserved"

  for_each = zipmap(
    [for o in netbox_available_prefix.tunnel_ipv6 : o.id],
    [for o in netbox_interface.tunnel : o.id],
  )

  tags = toset(var.tags)

  depends_on = [
    netbox_ip_address.reserve_zero,
    netbox_available_ip_address.tunnel_peer_ipv6,
  ]

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}

resource "netbox_available_ip_address" "tunnel_peer_ipv6" {
  prefix_id = each.value.id

  status = "reserved"

  for_each = netbox_available_prefix.tunnel_ipv6

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}
