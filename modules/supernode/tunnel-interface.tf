resource "netbox_interface" "tunnel" {
  name        = "tun${index(tolist(var.core_router_names), each.key)}"
  description = each.key

  virtual_machine_id = var.vm_id

  tags = toset(var.tags)

  for_each = var.core_router_names
}
