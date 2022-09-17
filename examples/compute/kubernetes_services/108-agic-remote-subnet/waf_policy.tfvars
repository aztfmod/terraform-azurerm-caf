application_gateway_waf_policies = {
  wp1 = {
    name               = "aksagw-wafpo01"
    resource_group_key = "aks_re1"

    policy_settings = {
      enabled                     = true
      mode                        = "Prevention"
      request_body_check          = true
      file_upload_limit_in_mb     = 100
      max_request_body_size_in_kb = 128
    }

    managed_rules = {
      exclusion = {
        ex1 = {
          match_variable          = "RequestHeaderNames"
          selector                = "x-company-secret-header"
          selector_match_operator = "Equals"
        }
        ex2 = {
          match_variable          = "RequestCookieNames"
          selector                = "too-tasty"
          selector_match_operator = "EndsWith"
        }
      }
      managed_rule_set = {
        mrs1 = {
          type    = "OWASP"
          version = "3.1"
          rule_group_override = {
            rgo1 = {
              rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
              disabled_rules = [
                "920300",
                "920440"
              ]
            }
            rgo2 = {
              rule_group_name = "General"
              disabled_rules = [
                "200004"
              ]
            }
          }
        }
      }
    }
  }
}