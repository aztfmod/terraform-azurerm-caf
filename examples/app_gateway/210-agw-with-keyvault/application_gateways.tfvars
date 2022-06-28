application_gateways = {
  agw1_az1 = {
    resource_group_key = "rg_region1"
    name               = "app_gateway_example"
    vnet_key           = "vnet_region1"
    subnet_key         = "app_gateway_private"
    sku_name           = "WAF_v2"
    sku_tier           = "WAF_v2"
    capacity = {
      autoscale = {
        minimum_scale_unit = 0
        maximum_scale_unit = 10
      }
    }
    zones        = ["1"]
    enable_http2 = true

    identity = {
      managed_identity_keys = [
        "apgw_keyvault_secrets"
      ]
    }

    # Force TLSv1.2 minimum and secure cyphers
    # https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-ssl-policy-overview#predefined-tls-policy
    ssl_profiles = {
      profile1 = {
        name = "SecureTLS"
        ssl_policy = {
          policy_type = "Predefined"
          policy_name = "AppGwSslPolicy20220101S"
        }
      }
    }

    front_end_ip_configurations = {
      public = {
        name          = "public"
        public_ip_key = "example_agw_pip1_rg1"
        subnet_key    = "app_gateway_public"
      }
      private = {
        name                          = "private"
        vnet_key                      = "vnet_region1"
        subnet_key                    = "app_gateway_private"
        subnet_cidr_index             = 0 # It is possible to have more than one cidr block per subnet
        private_ip_offset             = 4 # e.g. cidrhost(10.10.0.0/25,4) = 10.10.0.4 => AGW private IP address
        private_ip_address_allocation = "Static"
      }
    }

    front_end_ports = {
      80 = {
        name     = "http-80"
        port     = 80
        protocol = "Http"
      }
      443 = {
        name     = "https-443"
        port     = 443
        protocol = "Https"
      }
      4431 = {
        name     = "https-4431"
        port     = 4431
        protocol = "Https"
      }
    }
  }
}
