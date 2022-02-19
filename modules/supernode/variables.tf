variable "vm_id" {
  type        = number
  description = "ID of an existing Virtual Machine (number)"
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
