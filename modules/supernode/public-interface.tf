resource "netbox_interface" "public" {
  name = "public"

  description = "Public"

  virtual_machine_id = var.vm_id

  tags = toset(var.tags)
}
