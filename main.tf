terraform {
  cloud {
    organization = "ffddorf"

    workspaces {
      tags = [
        "supernodes",
        "managed",
      ]
    }
  }
  required_providers {
    netbox = {
      source = "e-breuninger/netbox"
    }
  }
}

provider "netbox" {
  server_url = var.netbox_server
  api_token  = var.netbox_api_token
}

module "tag" {
  source = "./modules/tag"
}

module "cluster" {
  source = "./modules/cluster"
}

module "network" {
  source      = "./modules/network"
  prefix_ipv4 = var.prefix_ipv4
  prefix_ipv6 = var.prefix_ipv6

  tags = [ module.tag.name ]
}

module "tunnel" {
  source             = "./modules/tunnel"
  tunnel_prefix_ipv4 = var.tunnel_prefix_ipv4
  tunnel_prefix_ipv6 = var.tunnel_prefix_ipv6
}

data "netbox_virtual_machines" "supernodes" {
  filter {
    name  = "cluster_id"
    value = module.cluster.id
  }
}

locals {
  supernodes = {
    for vm in data.netbox_virtual_machines.supernodes.vms :
    vm.name => vm
  }
}

module "supernode" {
  source = "./modules/supernode"

  cluster_id = each.value.cluster_id
  vm_id      = each.value.vm_id
  name       = each.key

  prefix_ipv4_id = module.network.ipv4
  prefix_ipv6_id = module.network.ipv6

  tunnel_prefix_ipv4_id = module.tunnel.ipv4
  tunnel_prefix_ipv6_id = module.tunnel.ipv6

  core_router_names = var.core_router_names

  for_each = local.supernodes

  tags = [ module.tag.name ]
}
