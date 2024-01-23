vnets = {
  grafana_re1 = {
    resource_group_key = "grafana_re1"
    region             = "region1"
    vnet = {
      name          = "grafana-re1"
      address_space = ["10.0.0.0/24"]
    }
    subnets = {
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["10.0.0.0/27"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}
