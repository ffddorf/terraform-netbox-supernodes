resource "netbox_available_prefix" "public_ipv4" {
  description = "Loopback ${var.name}"
  status      = "reserved"

  parent_prefix_id = var.prefix_ipv4_id
  prefix_length    = 32
  is_pool          = true

  tags = toset(var.tags)
}

resource "netbox_available_ip_address" "public_ipv4" {
  status = "reserved"

  prefix_id    = netbox_available_prefix.public_ipv4.id
  interface_id = netbox_interface.public.id

  tags = toset(var.tags)

  lifecycle {
    ignore_changes = [
      status,
    ]
  }
}

resource "netbox_primary_ip" "v4" {
  ip_address_id      = netbox_available_ip_address.public_ipv4.id
  ip_address_version = 4
  virtual_machine_id = var.vm_id
}
