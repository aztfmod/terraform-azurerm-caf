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
    certificate_name_check = false

    # routing_rule = {
    #   name                    = "ExampleRouteRule1"
    #   accepted_protocols      = ["Http", "Https"]
    #   frontend_endpoints      = ["exampleFrontendEndpoint1"]
    #   forwarding_protocol = "MatchRequest"
    #   backend_pool_name   = "exampleBackendBing"
      
    # }

    routing_rule = {
      rr1 = {
        name               = "exampleRoutingRule1"
        frontend_endpoints = ["exampleFrontendEndpoint1"]
        accepted_protocols = ["Http", "Https"] 
        patterns_to_match  = ["/*"]           
        enabled            = true              
        configuration      = "Forwarding"        
        forwarding_configuration = {
          backend_pool_name                     = "exampleBackendBing1"
          cache_enabled                         = false       
          cache_use_dynamic_compression         = false       
          cache_query_parameter_strip_directive = "StripNone" 
          custom_forwarding_path                = ""
          forwarding_protocol                   = "MatchRequest"   
        }
        redirect_configuration = {
          custom_host         = ""             
          redirect_protocol   = "MatchRequest"   
          redirect_type       = "Found"        
          custom_fragment     = ""
          custom_path         = ""
          custom_query_string = ""
        }
      } 
    }
    
    # Following optional argument can be used to set a time out value between 0-240. If not passed, by default it will be set to 60
    # backend_pools_send_receive_timeout_seconds = 120
    
    # Following optional argument can be used to disable Front Door Load Balancer
    # load_balancer_enabled  =  false
    
    # Following optional argument can be used to pass a friendly name for the Front Door service
    # friendly_name          =  "ExampleFriendDoor"

    backend_pool_load_balancing = {
      lb1 = {
        name                            = "exampleLoadBalancingSettings1"
        sample_size                     = 4
        successful_samples_required     = 2
        additional_latency_milliseconds = 0 
      }                                     
    }

    backend_pool_health_probe = {
      hp1 = {
        name                = "exampleHealthProbeSetting1"
        path                = "/"
        protocol            = "Http"
        interval_in_seconds = 120    
      }                             
    }

    # backend_pool_load_balancing = {
    #   name = "exampleLoadBalancingSettings1"

    # }
    
    # backend_pool_health_probe = {
    #   name = "exampleHealthProbeSetting1"
    # }

    # backend_pool = {
    #   name = "exampleBackendBing"
    #   host_header = "www.bing.com"
    #   address     = "www.bing.com"
    #   http_port   = 80
    #   https_port  = 443
    #   load_balancing_name = "exampleLoadBalancingSettings1"
    #   health_probe_name   = "exampleHealthProbeSetting1"
    # }

    backend_pool = {
      bp1 = {
        name = "exampleBackendBing1"
        load_balancing_name = "exampleLoadBalancingSettings1"
        health_probe_name   = "exampleHealthProbeSetting1"
        backend = {
          be1 = {
            enabled     = true
            address     = "www.bing.com"
            host_header = "www.bing.com"
            http_port   = 80
            https_port  = 443
            priority    = 1  
            weight      = 50
          },
          be2 = {
            enabled     = true
            address     = "www.bing.co.uk"
            host_header = "www.bing.co.uk"
            http_port   = 80
            https_port  = 443
            priority    = 1 
            weight      = 50
          }
        }
        
      } 
    }

    # frontend_endpoint = {
    #   name                              = "exampleFrontendEndpoint1"
    #   host_name                         = "randomabcxyz-FrontDoor.azurefd.net"
    #   custom_https_provisioning_enabled = false
    # } 

    frontend_endpoint = {
      fe1 = {
        name                              = "exampleFrontendEndpoint1"
        host_name                         = "randomabcxyz-FrontDoor.azurefd.net"
        session_affinity_enabled          = false 
        session_affinity_ttl_seconds      = 0     
        custom_https_provisioning_enabled = false
        #Required if custom_https_provisioning_enabled is true
        custom_https_configuration = {
          certificate_source = "FrontDoor" 
          #If certificate source is AzureKeyVault the below are required:
          azure_key_vault_certificate_vault_id       = ""
          azure_key_vault_certificate_secret_name    = ""
          azure_key_vault_certificate_secret_version = ""
        }
        web_application_firewall_policy_link_name = ""  
      }
    } 
    
  }
}