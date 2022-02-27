variable "prefix_ipv4" {
  type        = string
  description = "Network prefix (IPv4, CIDR notation, e.g. '10.1.0.0/16')"
}

variable "prefix_ipv6" {
  type        = string
  description = "Network prefix (IPv6, CIDR notation, e.g. 'fd00:1::/48')"
}

variable "tags" {
  type        = list(string)
  description = "Tags for the resources (list of strings, default empty)"
  default     = []
}
