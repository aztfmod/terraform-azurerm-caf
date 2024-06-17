global_settings = {
  random_length  = "5"
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  front_door = {
    name = "front-door-rg"
  }
}

cdn_front_door_profiles = {
  profile1 = {
    name               = "profile1"
    resource_group_key = "front_door"
    sku_name           = "Standard_AzureFrontDoor"
    cdn_frontdoor_endpoints = {
      ep1 = {
        name    = "endpoint1"
        enabled = true
      }
    }
    cdn_frontdoor_origin_groups = {
      group2 = {
        name = "group2"
        health_probe = {
          probe1 = {
            interval_in_seconds = 240
            path                = "/healthProbe"
            protocol            = "Https"
            request_type        = "HEAD"
          }
        }
        load_balancing = {
          lb1 = {
            additional_latency_in_milliseconds = 0
            sample_size                        = 16
            successful_samples_required        = 3
          }
        }
      }
      group6 = {
        name = "group6"
        health_probe = {
          probe1 = {
            interval_in_seconds = 240
            path                = "/healthProbe"
            protocol            = "Https"
            request_type        = "HEAD"
          }
        }
        load_balancing = {
          lb1 = {
            additional_latency_in_milliseconds = 0
            sample_size                        = 16
            successful_samples_required        = 3
          }
        }
      }
    }
    cdn_frontdoor_origins = {
      origin1 = {
        name                           = "origin1"
        cdn_frontdoor_origin_group_key = "group2"
        enabled                        = true
        host_name                      = "contoso.com"
        certificate_name_check_enabled = false
        weight                         = 1
      }

      origin2 = {
        name                           = "origin2"
        cdn_frontdoor_origin_group_key = "group2"
        enabled                        = true
        host_name                      = "fabrikam.com"
        certificate_name_check_enabled = false
        weight                         = 1
      }
    }
    cdn_frontdoor_rule_sets = {
      ruleset1 = {
        name                      = "ruleset1"
        cdn_frontdoor_profile_key = "profile1"
      }
    }
    cdn_frontdoor_rules = {
      rule1 = {
        name                       = "rule1"
        cdn_frontdoor_rule_set_key = "ruleset1"
        order                      = 1
        behavior_on_match          = "Continue"
        actions = {
          route_configuration_override_actions = {
            cdn_frontdoor_origin_group_key = "group2"
            forwarding_protocol            = "HttpsOnly"
            query_string_caching_behavior  = "IgnoreQueryString"
            compression_enabled            = true
            cache_behavior                 = "HonorOrigin"
          }
          url_redirect_actions = {
            redirect1 = {
              redirect_type        = "PermanentRedirect"
              redirect_protocol    = "Https"
              query_string         = "clientIp={client_ip}"
              destination_path     = "/exampleredirection"
              destination_hostname = "contoso.com"
              destination_fragment = "UrlRedirect"
            }
          }
          request_header_action = {
            requestheader1 = {
              header_name   = "app"
              header_action = "Append"
              value         = "vc"
            }
            requestheader2 = {
              header_name   = "view"
              header_action = "Append"
              value         = "vc"
            }
          }
          response_header_action = {
            responseheader = {
              header_name   = "api"
              header_action = "Overwrite"
              value         = "vc"
            }
          }
        }
        conditions = {
          host_name_condition = {
            condition1 = {
              operator         = "Equal"
              negate_condition = false
              match_values     = ["www.contoso.com", "images.contoso.com", "video.contoso.com"]
              transforms       = ["Lowercase", "Trim"]
            }
            condition2 = {
              operator         = "Equal"
              negate_condition = false
              match_values     = ["www.abc.com", "images.xvz.com", "video.xyz.com"]
              transforms       = ["Lowercase", "Trim"]
            }
          }
        }
      }
    }
    cdn_frontdoor_custom_domains = {
      domain1 = {
        name      = "domain1"
        host_name = "contoso.com"
        tls = {
          certificate_type    = "ManagedCertificate"
          minimum_tls_version = "TLS12"
        }
      }
      domain2 = {
        name      = "domain2"
        host_name = "fabrikam.com"
        tls = {
          certificate_type    = "ManagedCertificate"
          minimum_tls_version = "TLS12"
        }
      }
    }
    cdn_frontdoor_routes = {
      route1 = {
        name                             = "route1"
        https_redirect_enabled           = false
        patterns_to_match                = ["/*"]
        supported_protocols              = ["Http", "Https"]
        cdn_frontdoor_endpoint_key       = "ep1"
        cdn_frontdoor_custom_domain_keys = ["domain1", "domain2"]
        cdn_frontdoor_origin_group_key   = "group2"
        cdn_frontdoor_origin_keys        = ["origin1", "origin2"]
        cdn_frontdoor_rule_set_keys      = ["ruleset1"]
        cache = {
          cache1 = {
            query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
            query_strings                 = ["account", "settings"]
            compression_enabled           = true
            content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
          }

        }
      }
    }
  }
}