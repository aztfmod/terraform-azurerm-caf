private_dns = {
  "privatelink.blob.core.windows.net" = {
    name               = "privatelink.blob.core.windows.net"
    resource_group_key = "agents"
    vnet_links = {
      bootstrap = {
        name     = "bootstrap"
        vnet_key = "bootstrap"
      }
    }

  }
  "privatelink.vaultcore.azure.net" = {
    name               = "privatelink.vaultcore.azure.net"
    resource_group_key = "agents"
    vnet_links = {
      bootstrap = {
        name     = "bootstrap"
        vnet_key = "bootstrap"
      }
    }

  }

}
