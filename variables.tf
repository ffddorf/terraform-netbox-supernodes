variable "netbox_server" {
  type    = string
  default = "https://netbox.freifunk-duesseldorf.de"
}

variable "netbox_api_token" {
  type      = string
  sensitive = true
}

variable "prefix_ipv4" {
  type        = string
  description = "Network prefix (IPv4, CIDR notation, e.g. '10.1.0.0/16')"
  default     = "45.151.166.0/24"
}

variable "prefix_ipv6" {
  type        = string
  description = "Network prefix (IPv6, CIDR notation, e.g. 'fd00:1::/48')"
  default     = "2001:678:b7c::/48"
}

variable "core_router_names" {
  type        = set(string)
  description = "Name of the core routers to connect to (list of strings, default empty)"
  default = [
    "CR3",
    "CR4",
  ]
}

variable "tunnel_prefix_ipv4" {
  type        = string
  description = "Tunnel prefix (IPv4, CIDR notation, e.g. '10.1.0.0/16')"
  default     = "10.129.0.0/16"
}

variable "tunnel_prefix_ipv6" {
  type        = string
  description = "Tunnel prefix (IPv6, CIDR notation, e.g. 'fd00:1::/48')"
  default     = "fdcb:aa6b:5532::/48"
}
