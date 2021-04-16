application_gateway_waf_policies = {
  wp1 = {
    name                              = "examplewafpolicy"
    resource_group_key                = "agw_waf"

    policy_settings = {
      enabled                     = true
      file_upload_limit_in_mb     = 100
      max_request_body_size_in_kb = 128
      mode                        = "Detection"
      request_body_check          = true
    }
    managed_rules = {
      managed_rule_set = {
        rule1 = {
          type    = "OWASP"
          version = "3.1"
        }
      }
    }
  }
}