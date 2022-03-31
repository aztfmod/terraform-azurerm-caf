azuread_conditional_access_policies = {
  conap1 = {
    display_name = "example policy"
    state        = "disabled"

    conditions = {
      client_app_types    = ["all"]
      sign_in_risk_levels = ["medium"]
      user_risk_levels    = ["medium"]

      applications = {
        included_applications = ["All"]
      }

      devices = {
        filter = {
          mode = "exclude"
          rule = "device.operatingSystem eq \"Doors\""
        }
      }

      locations = {
        included_locations = ["All"]
        excluded_locations = ["AllTrusted"]
      }

      platforms = {
        included_platforms = ["android"]
        excluded_platforms = ["iOS"]
      }

      users = {
        included_users = ["All"]
        excluded_users = ["GuestsOrExternalUsers"]
      }
    }

    grant_controls = {
      operator          = "OR"
      built_in_controls = ["mfa"]
    }

    session_controls = {
      application_enforced_restrictions = {
        enabled = true
      }

      cloud_app_security = {
        enabled                 = true
        cloud_app_security_type = "monitorOnly"
      }

      sign_in_frequency        = 10
      sign_in_frequency_period = "hours"
    }
  }
}