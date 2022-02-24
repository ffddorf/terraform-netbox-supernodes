output "ipv4" {
  value = data.netbox_prefix.ipv4.id
}

output "ipv6" {
  value = data.netbox_prefix.ipv6.id
}
