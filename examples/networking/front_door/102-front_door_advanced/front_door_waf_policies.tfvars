front_door_waf_policies = {
  wp1 = {
    name                              = "examplewafpolicy"
    resource_group_key                = "front_door"
    enabled                           = true
    mode                              = "Prevention"
    redirect_url                      = "https://www.contoso.com"
    custom_block_response_status_code = 403
    custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

    custom_rules = {
      rule1 = {
        name                           = "Rule1"
        enabled                        = true
        priority                       = 1
        rate_limit_duration_in_minutes = 1
        rate_limit_threshold           = 10
        type                           = "MatchRule"
        action                         = "Block"

        match_condition = {
          allow_remote_subnets = {
            match_variable     = "RemoteAddr"
            operator           = "IPMatch"
            negation_condition = false
            match_values       = ["192.168.1.0/24", "10.0.0.0/24"]
          }
          countries = {
            match_variable     = "RemoteAddr"
            operator           = "GeoMatch"
            negation_condition = false
            match_values = [
              "bahrain",
              "Singapore"
            ]
          }
        }

      }
    }

    managed_rules = {
      rule1 = {
        type    = "DefaultRuleSet"
        version = "1.0"
        exclusions = {
          ex1 = {
            match_variable = "QueryStringArgNames"
            operator       = "Equals"
            selector       = "not_suspicious"
          }
        }
        overrides = {
          or1 = {
            rule_group_name = "PROTOCOL-ATTACK"
            exclusions = {
              ex1 = {
                match_variable = "RequestHeaderNames"
                operator       = "StartsWith"
                selector       = "test"
              }
              ex2 = {
                match_variable = "RequestCookieNames"
                operator       = "EqualsAny"
                selector       = "*"
              }
            }
            rules = {
              921150 = {
                action  = "Log"
                enabled = true
                rule_id = "921150"
              }
              921151 = {
                action  = "Log"
                enabled = true
                rule_id = "921151"
                exclusions = {
                  ex1 = {
                    match_variable = "RequestHeaderNames"
                    operator       = "StartsWith"
                    selector       = "921151"
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

