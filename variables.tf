variable "netbox_server" {
  type = string
}

variable "netbox_api_token" {
  type      = string
  sensitive = true
}

variable "prefix_ipv4" {
  type        = string
  description = "Network prefix (IPv4, CIDR notation, e.g. '10.1.0.0/16')"
}

variable "prefix_ipv6" {
  type        = string
  description = "Network prefix (IPv6, CIDR notation, e.g. 'fd00:1::/48')"
}
