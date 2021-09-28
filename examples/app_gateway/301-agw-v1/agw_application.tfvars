
application_gateway_applications_v1 = {
  demo_app1 = {
    name                    = "demo_app1"
    application_gateway_key = "agw1"

    backend_pools = {
      demo = {
        name  = "demo_pool01"
        fqdns = ["babc-app-ptsg-5sspdemoappap-lo.babc-ase-ase01-pd.appserviceenvironment.net"]

        # ip_addresses = ["10.0.0.4", "10.0.0.5"]

        # app_services = {
        #   lz_key = ""
        #   key = ""
        # }
      }
    }

    http_settings = {
      demo = {
        name                        = "demo_http_setting01"
        front_end_port_key          = "80"
        host_name_from_backend_pool = true
        timeout                     = 45
      }
    }

    http_listeners = {
      public = {
        name                           = "demo_http_listener01"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "80"
        host_name                      = "demo1.app1.com"
      }
      public_ssl = {
        name                           = "demo_https_listener01"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "443"
        host_name                      = "demo1.app1.com"
        ssl_cert_key                   = "demo"
      }
    }

    request_routing_rules = {
      default = {
        name              = "default_demo_app1"
        rule_type         = "PathBasedRouting"
        http_listener_key = "public"
        backend_pool_key  = "demo"
        http_settings_key = "demo"
        url_path_map_key  = "demo"
      }
    }

    ssl_certs = {
      demo = {
        name = "demo"
        keyvault = {
          certificate_key = "demoapp1.cafsandpit.com"
        }
      }
    }

    url_path_maps = {
      demo = {
        name              = "test_path_map"
        paths             = "/test/*"
        rule_name         = "test_path_rule"
        backend_pool_key  = "demo"
        http_settings_key = "demo"
      }
    }
  }
}