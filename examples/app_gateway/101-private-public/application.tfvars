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
      public_82 = {
        name                           = "demo-app1-82-public"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "82"
        host_name                      = "cafdemo.com"
        request_routing_rule_key       = "path_based"
      }
    }

    request_routing_rules = {
      default = {
        rule_type = "Basic"
        #rewrite_rule_set_key = "rule_set_1"
      }
      path_based = {
        rule_type        = "PathBasedRouting"
        url_path_map_key = "path_map_1"
      }
    }

    url_path_maps = {
      path_map_1 = {
        name                         = "path_map_1"
        default_rewrite_rule_set_key = "rule_set_1"
        path_rules = {
          pathRuleIdentity = {
            name  = "pathRuleIdentity"
            paths = ["/identity*"]
            #rewrite_rule_set_key = "rule_set_1"
          }

          pathRuleAuthorisation = {
            name  = "pathRuleAuthorization"
            paths = ["/authorization*"]
            #rewrite_rule_set_key = "rule_set_1"
          }
        }
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

    rewrite_rule_sets = {
      rule_set_1 = {
        name = "header-rules"
        rewrite_rules = {
          rule_1 = {
            name          = "server-header-remove"
            rule_sequence = 100
            #conditions = {
            #condition_1 = {
            #variable = "http_status"
            #pattern = "200"
            #ignore_case = true
            #negate = false
            #}
            #}
            response_header_configurations = {
              server_header = {
                header_name  = "Server"
                header_value = "" # Use blank value to remove header
              }
            }
            # url = {
            #   path          = ""
            #   query_string  = ""
            #   reroute       = false
            # }
          }

          rule_2 = {
            name          = "hsts-add-header"
            rule_sequence = 101
            #conditions = {
            #condition_1 = {
            #variable = "http_status"
            #pattern = "200"
            #ignore_case = true
            #negate = false
            #}
            #}
            response_header_configurations = {
              hsts_header = {
                header_name  = "Strict-Transport-Security"
                header_value = "max-age=31536000"
              }
            }
            # url = {
            #   path          = ""
            #   query_string  = ""
            #   reroute       = false
            # }
          }

          rule_3 = {
            name          = "add-request-header"
            rule_sequence = 102
            #conditions = {
            #condition_1 = {
            #variable = "http_status"
            #pattern = "200"
            #ignore_case = true
            #negate = false
            #}
            #}
            request_header_configurations = {
              foo_header = {
                header_name  = "foo"
                header_value = "123456"
              }
            }
            # url = {
            #   path          = ""
            #   query_string  = ""
            #   reroute       = false
            # }
          }
        }
      }
    }
  }
}