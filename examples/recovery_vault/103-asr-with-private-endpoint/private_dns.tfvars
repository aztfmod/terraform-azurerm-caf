
private_dns = {
  dns1 = {
    name               = "test-dns.dn1.internal"
    resource_group_key = "primary"

    vnet_links = {
      vnet_region1 = {
        name     = "vnet_region1"
        vnet_key = "vnet_region1"
      }
    }
  }
}