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

