application_gateway_applications = {
  demo_app1_80_private = {

    application_gateway_key = "agw1"
    name                    = "demoapp1"

    listeners = {
      private = {
        name                           = "demo-app1-80-private"
        front_end_ip_configuration_key = "private"
        front_end_port_key             = "80"
        host_name                      = "cafdemo.com"
        request_routing_rule_key       = "default"
      }
      public = {
        name                           = "demo-app1-80-public"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "81"
        host_name                      = "cafdemo.com"
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