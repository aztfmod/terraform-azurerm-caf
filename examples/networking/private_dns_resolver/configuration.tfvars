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



vnet ={
  vnet_test = {
  name                = "vnet-test"
  resource_group_key = "private_dns_resolver_region1"
  address_space       = ["10.0.0.0/16"]
  }
}

private_dns_resolver = {
  private_dns_resolver_test = {
  name                = "test-resolver"
  resource_group_key = "private_dns_resolver_region1"
  vnet_key            = "vnet_test"
  }
}
