resource "netbox_interface" "public" {
  name = "public"

  virtual_machine_id = var.vm_id

  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "public_ipv4" {
  status = "reserved"

  prefix_id    = var.prefix_ipv4_id
  interface_id = netbox_interface.public.id

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}

resource "netbox_available_ip_address" "public_ipv6" {
  status = "reserved"

  prefix_id    = var.prefix_ipv6_id
  interface_id = netbox_interface.public.id

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}

resource "netbox_interface" "tunnel" {
  name        = "tun${index(tolist(var.core_router_names), each.key)}"
  description = each.key

  virtual_machine_id = var.vm_id

  tags = toset(var.tags)

  for_each = var.core_router_names
}

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

resource "netbox_available_ip_address" "tunnel_ipv4" {
  prefix_id    = each.key
  interface_id = each.value

  status = "reserved"

  for_each = zipmap(
    [for o in netbox_available_prefix.tunnel_ipv4 : o.id],
    [for o in netbox_interface.tunnel : o.id],
  )

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}
