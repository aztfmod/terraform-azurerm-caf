global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  private_dns_resolver_region1 = {
    name   = "private-dns-resolver-rg"
    region = "region1"
  }
}



vnets ={
  vnet_test = {
    region = "region1"
    resource_group_key = "private_dns_resolver_region1"
    vnet = {
       name          = "vnet-test"
       address_space = ["100.64.100.0/22"]
    }
  }
}

private_dns_resolvers = {
  private_dns_resolver_test = {
    name                = "test-resolver"
    resource_group_key  = "private_dns_resolver_region1"
    vnet_key            = "vnet_test"
  }
}
