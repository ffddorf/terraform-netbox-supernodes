variable "vm_id" {
  type        = number
  description = "ID of an existing Virtual Machine (number)"
}

variable "name" {
  type        = string
  description = "Name of the Supernode (string)"
}

variable "cluster_id" {
  type        = number
  description = "ID of an existing VM Cluster (number)"
}

variable "prefix_ipv4_id" {
  type        = string
  description = "ID of the Supernode IPv4 prefix (number)"
}

variable "prefix_ipv6_id" {
  type        = string
  description = "ID of the Supernode IPv6 prefix (number)"
}

variable "tunnel_prefix_ipv4_id" {
  type        = string
  description = "ID of the tunnel IPv4 prefix (number)"
}

variable "tunnel_prefix_ipv6_id" {
  type        = string
  description = "ID of the tunnel IPv6 prefix (number)"
}

variable "core_router_names" {
  type        = set(string)
  default     = []
  description = "Name of the core routers to connect to (list of strings, default empty)"
}

variable "tags" {
  type        = list(string)
  description = "Tags for the resources (list of strings, default empty)"
  default     = []
}
