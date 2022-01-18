application_gateway_applications = {
  demo_app1_az1_agw1 = {

    name                    = "demoapp1"
    application_gateway_key = "agw1_az1"

    listeners = {
      private = {
        name                           = "demoapp1-80-private"
        front_end_ip_configuration_key = "private"
        front_end_port_key             = "80"
        host_name                      = "demoapp1.cafdemo.com"
        request_routing_rule_key       = "default"
      }
      private_ssl = {
        name                           = "demoapp1-443-private"
        front_end_ip_configuration_key = "private"
        front_end_port_key             = "443"
        host_name                      = "demoapp1.cafdemo.com"
        request_routing_rule_key       = "default"
        keyvault_certificate = {
          certificate_key = "demoapp1.cafdemo.com"
          // To use manual uploaded cert
          # certificate_name = "testkhairi"
          # keyvault_key     = "certificates"
          #  keyvault_id     = "/subscriptions/97958dac-xxxx-xxxx-xxxx-9f436fa73bd4/resourceGroups/jmtv-rg-example-app-gateway-re1/providers/Microsoft.KeyVault/vaults/jmtv-kv-certs"
        }
      }
      public_ssl = {
        name                           = "demoapp1-4431-public"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "4431"
        host_name                      = "demoapp1.cafdemo.com"
        request_routing_rule_key       = "default"
        keyvault_certificate = {
          certificate_key = "demoapp1.cafdemo.com"
          // To use manual uploaded cert
          # certificate_name = "testkhairi"
          # keyvault_id     = "/subscriptions/97958dac-xxxx-xxxx-xxxx-9f436fa73bd4/resourceGroups/jmtv-rg-example-app-gateway-re1/providers/Microsoft.KeyVault/vaults/jmtv-kv-certs"
        }
      }
    }


    request_routing_rules = {
      default = {
        rule_type = "Basic"
      }
    }

    backend_http_setting = {
      port                                = 443
      protocol                            = "Https"
      pick_host_name_from_backend_address = true
    }

    backend_pool = {
      fqdns = [
        "cafdemo.appserviceenvironment.net"
      ]
    }

  }
}