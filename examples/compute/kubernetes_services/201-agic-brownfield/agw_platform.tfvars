# application_gateway_platforms create an AGW where the configuration can be managed in a different tfstate or in aks.
# as opposed to application_gateways that require all application configurations to be in the same deployment as the gateway.
# when deploying in landingones prefer the application_gateway_platforms
application_gateway_platforms = {
  agw = {
    name = "app_gateway_example"
    # lz_key     = ""                   # Set the lz_key if the vnet and subnet are remote
    vnet_key   = "spoke_aks_re1" # Check in the networking.tfvars for more details
    subnet_key = "application_gateway"
    sku_name   = "WAF_v2"
    sku_tier   = "WAF_v2"
    resource_group = {
      # lz_key = ""                     # Set the lz_key if the resource group is remote
      key = "aks_re1"
    }
    capacity = {
      autoscale = {
        minimum_scale_unit = 1
        maximum_scale_unit = 5
      }
    }
    zones        = ["1", "2", "3"]
    enable_http2 = true

    ssl_policy = {
      policy_name = "AppGwSslPolicy20170401S"
      policy_type = "Predefined"
    }

    identity = {
      managed_identity_keys = ["aks_usermsi"]
      # remote = {                      # Use that block to reference a remote user MSI
      #   "value of the lz_key" = {
      #     managed_identity_keys = [
      #       "agw"
      #     ]
      #   }
      # }
    }

    front_end_ip_configurations = {
      public = {
        name = "public"
        # lz_key        = ""
        public_ip_key = "agw"
      }
      private = {
        name = "private"
        # lz_key                        = ""
        vnet_key                      = "spoke_aks_re1"
        subnet_key                    = "application_gateway"
        subnet_cidr_index             = 0 # It is possible to have more than one cidr block per subnet
        private_ip_offset             = 4 # e.g. cidrhost(10.10.0.0/25,4) = 10.10.0.4 => AGW private IP address
        private_ip_address_allocation = "Static"
      }
    }

    ssl_certs = {
      default = {
        name = "default"
        keyvault = {
          # lz_key           = ""
          key              = "certificates"
          certificate_name = "default-domain-name-com" # As is line 7 on the certificates.tfvars
        }
      }
    }

    front_end_ports = {
      443 = {
        name     = "https"
        port     = 443
        protocol = "Https"
      }
    }

    #default: wont be able to change after creation as this is required for agw tf resource
    default = {
      frontend_port_key             = "443"
      frontend_ip_configuration_key = "public"
      backend_address_pool_name     = "default-beap"
      http_setting_name             = "default-be-htst"
      listener_name                 = "default-httplstn"
      request_routing_rule_name     = "default-rqrt"
      cookie_based_affinity         = "Disabled"
      request_timeout               = "60"
      rule_type                     = "Basic"
      ssl_cert_key                  = "default" # ssl_certs key as defined above in line 59
    }

  }
}