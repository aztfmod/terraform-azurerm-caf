frontdoor_rules_engine = {
  http_security_header = {
    name               = "http_security_header"
    resource_group_key = "front_door"
    frontdoor = {
      key = "front_door1"
    }
    rule = {
      strict_transport_security = {
        name     = "strict_transport_security"
        priority = "1"
        action = {
          response_header = [
            {
              header_action_type = "Append"
              header_name        = "Strict-Transport-Security"
              value              = "max-age=31536000; includeSubDomains"
            }
          ]
        }
      }
      referrer_policy = {
        name     = "referrer_policy_rule"
        priority = "2"
        action = {
          response_header = [
            {
              header_action_type = "Append"
              header_name        = "Referrer-Policy"
              value              = "no-referrer-when-downgrade"
            }
          ]
        }
      }
      x_frame_options = {
        name     = "x_frame_options_rule"
        priority = "3"
        action = {
          response_header = [
            {
              header_action_type = "Append"
              header_name        = "X-Frame-Options"
              value              = "sameorigin"
            }
          ]
        }
      }
      x_content_type_options = {
        name     = "x_content_type_options"
        priority = "4"
        action = {
          response_header = [
            {
              header_action_type = "Append"
              header_name        = "X-Content-Type-Options"
              value              = "nosniff"
            }
          ]
        }
      }
      x_xss_protection = {
        name     = "x_xss_protection"
        priority = "5"
        action = {
          response_header = [
            {
              header_action_type = "Append"
              header_name        = "X-XSS-Protection"
              value              = "1; mode=block"
            }
          ]
        }
      }
    }
  }
}