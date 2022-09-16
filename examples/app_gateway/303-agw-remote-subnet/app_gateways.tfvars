application_gateway_platforms = {
  agw1 = {
    resource_group_key = "agw_re1" 
    name               = "app_gateway_example"
    lz_key             = "networking"
    subnet_key         = "web01"
    sku_name           = "WAF_v2"
    sku_tier           = "WAF_v2"

    waf_policy = {
      key = "wp1"
    }

    capacity = {
      autoscale = {
        minimum_scale_unit = 1
        maximum_scale_unit = 5
      }
    }
    zones        = ["1"]
    enable_http2 = true

    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["agw_keyvault_secrets"]
    }

    front_end_ip_configurations = {
      public = {
        name          = "public"
        public_ip_key = "agw_pip1"
      }
      private = {
        name                          = "private"
        lz_key                        = "networking"
        subnet_key                    = "web01"
        subnet_cidr_index             = 0 
        private_ip_offset             = 4 
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
    }

    default = {
      frontend_port_key             = "80"
      frontend_ip_configuration_key = "private"
      backend_address_pool_name     = "default-beap"
      http_setting_name             = "default-be-htst"
      listener_name                 = "default-httplstn"
      request_routing_rule_name     = "default-rqrt"
      cookie_based_affinity         = "Disabled"
      request_timeout               = "60"
      rule_type                     = "Basic"
    }
  }
}

public_ip_addresses = {
  agw_pip1 = {
    name                    = "public-ip-example"
    resource_group_key      = "agw_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}