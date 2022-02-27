resource "netbox_available_prefix" "public_ipv6" {
  description = "Loopback ${var.name}"
  status      = "reserved"

  parent_prefix_id = var.prefix_ipv6_id
  prefix_length    = 128
  is_pool          = true

  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "public_ipv6" {
  status = "reserved"

  prefix_id    = netbox_available_prefix.public_ipv6.id
  interface_id = netbox_interface.public.id

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}

resource "netbox_primary_ip" "v6" {
  ip_address_id      = netbox_available_ip_address.public_ipv6.id
  ip_address_version = 6
  virtual_machine_id = var.vm_id
}
