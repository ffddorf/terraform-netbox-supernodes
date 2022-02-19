resource "netbox_interface" "public" {
  name = "public"

  virtual_machine_id = var.vm_id
}

resource "netbox_available_ip_address" "public_ipv4" {
  status = "reserved"

  prefix_id    = var.prefix_ipv4_id
  interface_id = netbox_interface.public.id
}

resource "netbox_available_ip_address" "public_ipv6" {
  status = "reserved"

  prefix_id    = var.prefix_ipv6_id
  interface_id = netbox_interface.public.id
}
