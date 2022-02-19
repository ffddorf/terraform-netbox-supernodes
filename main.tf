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

module "cluster" {
  source = "./modules/cluster"
}

module "network" {
  source      = "./modules/network"
  prefix_ipv4 = var.prefix_ipv4
  prefix_ipv6 = var.prefix_ipv6
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

  cluster_id = module.cluster.id
  vm_id      = each.value.vm_id

  prefix_ipv4_id = module.network.ipv4
  prefix_ipv6_id = module.network.ipv6

  for_each = local.supernodes
}
