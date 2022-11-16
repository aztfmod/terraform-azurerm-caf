front_doors = {
  front_door1 = {
    name               = "sales-rg1"
    resource_group_key = "front_door"
    # Keyvault key hosting the ssl certificates
    keyvault_key = "cert_secrets"

    routing_rule = {
      rr1 = {
        name                   = "exampleRoutingRule1"
        frontend_endpoint_keys = ["fe1"]
        accepted_protocols     = ["Http", "Https"]
        patterns_to_match      = ["/*"]
        configuration          = "Forwarding"
        forwarding_configuration = {
          backend_pool_name = "bing"
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
        name = "exampleLoadBalancingSettings1"
      }
    }

    backend_pool_health_probe = {
      hp1 = {
        name = "exampleHealthProbeSetting1"
      }
    }

    backend_pool = {
      bp1 = {
        name               = "bing"
        load_balancing_key = "lb1"
        health_probe_key   = "hp1"
        backend = {
          be1 = {
            address     = "www.bing.com"
            host_header = "www.bing.com"
            http_port   = 80
            https_port  = 443
          },
          be2 = {
            address     = "www.bing.co.uk"
            host_header = "www.bing.co.uk"
            http_port   = 80
            https_port  = 443
          }
        }
      }
    }

    frontend_endpoints = {
      fe1 = {
        name                              = "exampleFrontendEndpoint1"
        custom_https_provisioning_enabled = false
        #Required if custom_https_provisioning_enabled is true
        custom_https_configuration = {
          certificate_source = "AzureKeyVault"
          #If certificate source is AzureKeyVault the below are required:
          # azure_key_vault_certificate_vault_id       = "/subscriptions/[subscription_id]/resourceGroups/[resource_group_name]/providers/Microsoft.KeyVault/vaults/kv-certsecrets-ccmcj"
          # azure_key_vault_certificate_secret_name    = "test"
          # azure_key_vault_certificate_secret_version = "b672b38ce10245b8bd3ba75924c80d3d"
          #
          #### Or if created from CAF module
          #
          # certificate = {
          #   key = "sales_application"
          #   # lz_key = ""
          # }
        }
        front_door_waf_policy = {
          key = "wp1"
          # lz_key = ""
        }
      }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "azure_front_door"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }
  }
}
