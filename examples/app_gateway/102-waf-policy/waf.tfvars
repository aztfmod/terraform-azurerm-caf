application_gateway_waf_policies = {
  wp1 = {
    name               = "examplewafpolicy"
    resource_group_key = "agw_waf"

    custom_rules = {
      rule1 = {
        name      = "Rule1"
        priority  = 1
        rule_type = "MatchRule"
        match_conditions = {
          mc1 = {
            operator           = "IPMatch"
            negation_condition = false
            match_values       = ["192.168.1.0/24", "10.0.0.0/24"]
            match_variables = {
              mv1 = {
                variable_name = "RemoteAddr"
              }
            }
          }
        }
        action = "Block"
      }
      rule2 = {
        name      = "Rule2"
        priority  = 2
        rule_type = "MatchRule"
        match_conditions = {
          mc1 = {
            operator           = "IPMatch"
            negation_condition = false
            match_values       = ["192.168.1.0/24"]
            match_variables = {
              mv1 = {
                variable_name = "RemoteAddr"
              }
            }
          }
          mc2 = {
            operator           = "Contains"
            negation_condition = false
            match_values       = ["Windows"]
            match_variables = {
              mv1 = {
                variable_name = "RequestHeaders"
                selector      = "UserAgent"
              }
            }
          }
        }
        action = "Block"
      }
    }

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
          }
        }
      }
    }
  }
}