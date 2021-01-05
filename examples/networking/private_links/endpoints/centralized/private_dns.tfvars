
private_dns = {
  dns1 = {
    name               = "test-dns.dn1.internal"
    resource_group_key = "rg1"

    vnet_links = {
      vnet_01 = {
        name     = "vnet_01"
        vnet_key = "vnet_01"
      }

    }
  }
}