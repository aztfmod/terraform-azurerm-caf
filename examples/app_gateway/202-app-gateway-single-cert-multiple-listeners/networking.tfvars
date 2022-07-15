vnets = {
  shared_spoke = {
    resource_group_key = "core_services"
    region = "region1"

    vnet = {
      name          = "dev-core-services"
      address_space = ["10.1.0.0/20"]
    }
    
    specialsubnets = {}
    
    subnets = {
      app-gateway-public = {
        name            = "app_gateway_public"
        cidr            = ["10.1.0.0/24"]
      }
      app-gateway-private = {
        name = "app_gateway_private"
        cidr = ["10.1.1.0/24"]
      }
    }
  }
}
