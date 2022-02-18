output "ipv4" {
  value = netbox_available_prefix.ipv4.id
}

output "ipv6" {
  value = netbox_available_prefix.ipv6.id
}
