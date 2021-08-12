application_gateways = {
  agw1 = {
    resource_group_key = "agw_region1"
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
      81 = {
        name     = "http-81"
        port     = 81
        protocol = "Http"
      }
      82 = {
        name     = "http-82"
        port     = 82
        protocol = "Http"
      }
      443 = {
        name     = "https-443"
        port     = 443
        protocol = "Https"
      }
    }
  }
}