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
