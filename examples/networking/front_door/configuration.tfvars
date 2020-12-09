global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  front_door_region1 = {
    name = "front-door-rg"
    region = "region1"
  }
}

front_doors = {
  front_door1 = {
    name                = "sales-rg1"
    region              = "region1"
    resource_group_key = "front_door_region1"

    routing_rule = {
      name                    = "ExampleRouteRule1"
      accepted_protocols      = ["Http", "Https"]
      patterns_to_match       = ["/*"]
      frontend_endpoints      = ["exampleFrontendEndpoint1"]
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "exampleBackendBing"
      # forwarding_configuration = {}
    }

    backend_pool_load_balancing = {
      name = "exampleLoadBalancingSettings1"

    }
    
    backend_pool_health_probe = {
      name = "exampleHealthProbeSetting1"
    }  
    
  }
}

# vnets = {
#   vnet_test = {
#     resource_group_key = "private_dns_region1"
#     vnet = {
#       name          = "test-vnet"
#       address_space = ["10.10.100.0/24"]
#     }
#     specialsubnets = {

#     }
#     subnets = {

#     }
#   }
# }

