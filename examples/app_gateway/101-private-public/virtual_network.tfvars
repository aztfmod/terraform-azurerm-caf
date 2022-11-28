vnets = {
  vnet_region1 = {
    resource_group_key = "agw_region1"
    vnet = {
      name          = "app_gateway"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      app_gateway_private = {
        name    = "app_gateway-private"
        cidr    = ["10.100.100.0/25"]
        nsg_key = "application_gateway"
      }
      app_gateway_public = {
        name    = "app_gateway-public"
        cidr    = ["10.100.100.128/25"]
        nsg_key = "application_gateway_public_ingress"
      }
    }

  }
}