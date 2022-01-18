private_dns = {
  backup_region1 = {
    name               = "privatelink.sea.backup.windowsazure.com"
    resource_group_key = "dnszones"

    vnet_links = {
      vnet_region1 = {
        name     = "vnet_region1"
        vnet_key = "vnet_region1"
      }
    }
  }
}