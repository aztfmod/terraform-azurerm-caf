
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
      demo2 = {
        name  = "demo_pool02"
        fqdns = ["babc-app-ptsg-5sspdemoappap2-lo.babc-ase-ase01-pd.appserviceenvironment.net"]
      }
      demo3 = {
        name  = "demo_pool03"
        fqdns = ["babc-app-ptsg-5sspdemoappap3-lo.babc-ase-ase01-pd.appserviceenvironment.net"]
      }
      demo4 = {
        name  = "demo_pool04"
        fqdns = ["babc-app-ptsg-5sspdemoappap4-lo.babc-ase-ase01-pd.appserviceenvironment.net"]
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
        name                 = "default_demo_app1"
        rule_type            = "PathBasedRouting"
        http_listener_key    = "public"
        backend_pool_key     = "demo"
        http_settings_key    = "demo"
        url_path_map_key     = "demo"
        priority             = 10000
        rewrite_rule_set_key = "rrs1"
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
        name                      = "test_path_map"
        paths                     = "/test/*"
        rule_name                 = "test_path_rule"
        default_backend_pool_key  = "demo"
        backend_pool_key          = "demo"
        default_http_settings_key = "demo"
        http_settings_key         = "demo"
        rewrite_rule_set_key      = "rrs1"
      }
    }

    url_path_rules = {
      rule1 = {
        name              = "rule1-demo"
        url_path_map_key  = "demo"
        paths             = "/test/rule1/*"
        backend_pool_key  = "demo2"
        http_settings_key = "demo"
      }
      rule2 = {
        name              = "rule2-demo"
        url_path_map_key  = "demo"
        paths             = "/test/rule2/*"
        backend_pool_key  = "demo3"
        http_settings_key = "demo"
      }
      rule3 = {
        name              = "rule3-demo"
        url_path_map_key  = "demo"
        paths             = "/test/rule3/*"
        backend_pool_key  = "demo4"
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

    rewrite_rule_sets = {
      rrs1 = {
        name = "test_rewrite_rule_set"
      }
    }

    rewrite_rules = {
      rr1 = {
        name                 = "test_rr"
        rewrite_rule_set_key = "rrs1"
        request_headers      = "Content-Type=application/json"
        sequence             = "1"
      }
    }

    rewrite_rule_conditions = {
      rrc1 = {
        rewrite_rule_set_key = "rrs1"
        rewrite_rule_key     = "rr1"
        variable             = "http_req_Accept"
        ignore_case          = true
        negate               = true
        pattern              = "test"
      }
    }
  }
}