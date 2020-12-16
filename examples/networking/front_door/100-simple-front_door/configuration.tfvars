resource_groups = {
  front_door_region1 = {
    name = "front-door-rg"        
  }
}

front_doors = {
  front_door1 = {
    name                = "sales-rg1"
    region              = "region1"
    resource_group_key = "front_door_region1"
    certificate_name_check = false

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

    waf_policy = {
      # wp1 = {
      name  = "examplewafpolicy"
      enabled = true
      mode                              = "Prevention"
      redirect_url                      = "https://www.contoso.com"
      custom_block_response_status_code = 403
      custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

      custom_rule = {
        rule1 = {
          name                           = "Rule1"
          enabled                        = true
          priority                       = 1
          rate_limit_duration_in_minutes = 1
          rate_limit_threshold           = 10
          type                           = "MatchRule"
          action                         = "Block"

          match_condition = {
            mc1 = {
              match_variable     = "RemoteAddr"
              operator           = "IPMatch"
              negation_condition = false
              match_values       = ["192.168.1.0/24", "10.0.0.0/24"]
            }
          }

        }
      }

      managed_rule = {
        rule1 = {
          type    = "DefaultRuleSet"
          version = "1.0"
          exclusion = {
            ex1 = {
              match_variable = "QueryStringArgNames"
              operator       = "Equals"
              selector       = "not_suspicious"
            }
          }
          
        }
      }
      
    }
    
  }
}