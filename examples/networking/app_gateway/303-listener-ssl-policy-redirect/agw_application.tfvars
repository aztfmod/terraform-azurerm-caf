
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

    # frontend_ports to be used only if application configuraiton uses non standards https/https ports i.e anything other than 80/443
    frontend_ports = {
      "8443" = {
        name = "8443"
        port = 8443
      }
      "8444" = {
        name = "8443"
        port = 8443
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
        name                           = "demo_https_listener02"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "443"
        host_name                      = "demo1.app1.com"
        ssl_cert_key                   = "demo"
      }
      public_ssl2 = {
        name                           = "demo_https_listener03"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "8444"
        host_name                      = "demo1.app1.com"
        ssl_cert_key                   = "demo"
      }
      private_ssl = {
        name                           = "demo_https_listener03"
        front_end_ip_configuration_key = "private"
        front_end_port_key             = "8443"
        host_name                      = "demo1.app1.com"
        ssl_cert_key                   = "demo"
      }

    }

    redirect_configurations = {
      redirect-https = {
        name                 = "redirect-https"
        redirect_type        = "Permanent"             #Permanent,Temporary,Found,SeeOther
        target_listener_name = "demo_https_listener03" #redirection to a listener
        #target_url           = "https://bing.com"
        include_path         = true
        include_query_string = false
      }
      redirect-https-url = {
        name                 = "redirect-https-url"
        redirect_type        = "Permanent"        #Permanent,Temporary,Found,SeeOther
        target_url           = "https://bing.com" #redirection to external site/url
        include_path         = true
        include_query_string = false
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
        priority          = 100
      }
      external1 = {
        name                = "demo_app1_external_rd_listener"
        rule_type           = "Basic"
        http_listener_key   = "public_ssl"
        url_path_map_key    = "demo"
        priority            = 102
        redirect_config_key = "redirect-https" #listener in the redirect config should not be the same listener provided above as http_listener_key
      }
      external2 = {
        name                = "route_rule_redirect_url"
        rule_type           = "Basic"
        http_listener_key   = "public_ssl2"
        url_path_map_key    = "demo"
        priority            = 103
        redirect_config_key = "redirect-https-url"
      }
    }

    ssl_certs = {
      demo = {
        name = "demo"
        keyvault = {
          certificate_key = "demoapp1.cafsandpit.com"

          # lz_key                  = "" #remote keyvault

          # certificate_request_key = "" #for cert request

          # manual cert
          # key                     = "" #keyvault key
          # certificate_name        = "" #manual cert name
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

    url_path_rules = {
      rule1 = {
        name              = "rule1-demo"
        url_path_map_key  = "demo"
        paths             = "/test/rule1/*"
        backend_pool_key  = "demo"
        http_settings_key = "demo"
      }
      rule2 = {
        name              = "rule2-demo"
        url_path_map_key  = "demo"
        paths             = "/test/rule2/*"
        backend_pool_key  = "demo"
        http_settings_key = "demo"
      }
    }

    probes = {
      test = {
        name                         = "test-http"
        protocol                     = "Http" # Http or Https
        host                         = "test.com"
        host_name_from_http_settings = false
        # port                                    = "" # Leave not set if pick port from backend http settings
        path               = "/api/health"
        interval           = "60"
        timeout            = "60"
        threshold          = "3"
        min_servers        = "0"
        match_status_codes = "200-499"
      }
    }
  }
}


