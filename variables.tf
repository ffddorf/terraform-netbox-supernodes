variable "netbox_server" {
  type = string
}

variable "netbox_api_token" {
  type      = string
  sensitive = true
}

variable "supernodes" {
  type = map(object({
    name         = string
    ipv4_address = string
    ipv6_address = string
  }))
}
