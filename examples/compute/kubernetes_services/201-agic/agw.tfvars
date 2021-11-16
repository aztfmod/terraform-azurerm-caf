application_gateways = {
  agw1_az1 = {
    resource_group_key = "aks_re1"
    name               = "app_gateway"
    vnet_key           = "spoke_aks_re1"
    subnet_key         = "application_gateway"
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
        public_ip_key = "agw_pip1_re1"
        subnet_key    = "application_gateway"
      }
      private = {
        name                          = "private"
        vnet_key                      = "spoke_aks_re1"
        subnet_key                    = "application_gateway"
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
    }
  }
}

application_gateway_applications = {
  aspnetapp_az1_agw1 = {

    name                    = "aspnetapp"
    application_gateway_key = "agw1_az1"

    listeners = {
      public = {
        name                           = "public-80"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "80"
        # host_name                      = "www.y4plq60ubbbiop9w1dh36tlgfpxqctfj.com"
        dns_zone = {
          key         = "dns_zone1"
          record_type = "a"
          record_key  = "agw"
        }

        request_routing_rule_key = "default"
        # key_vault_secret_id = ""
        # keyvault_certificate = {
        #   certificate_key = "aspnetapp.cafdemo.com"
        # }
      }
    }


    request_routing_rules = {
      default = {
        rule_type = "Basic"
      }
    }

    backend_http_setting = {
      port                                = 80
      protocol                            = "Http"
      pick_host_name_from_backend_address = true
      # trusted_root_certificate_names      = ["wildcard-ingress"]
    }



    backend_pool = {
      fqdns = [
        "bu0001a0008-00.aks-ingress.contoso.com"
      ]
    }

  }
}
