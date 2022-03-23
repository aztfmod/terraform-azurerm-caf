global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  alerts = {
    name = "alerts"
  }
}

monitoring = {
  service_health_alerts = {
    enable_service_health_alerts = true
    name                         = "service-health-alert"
    action_group_name            = "ag_servicehealth"
    shortname                    = "HealthAlerts"
    resource_group_key           = "alerts"

    email_alert_settings = {
      email_alert1 = {
        name                    = "email_alert_servicehealth_me"
        email_address           = "email1@domain"
        use_common_alert_schema = false
      } #remove the following block if additional email alerts aren't needed.
      email_alert2 = {
        name                    = "email_alert_servicehealth_somoneelse"
        email_address           = "email2@domain"
        use_common_alert_schema = false
      }
    } #add more email alerts by repeating the block.

    #more alert settings can be dynamically added/removed by commenting in/out the following blocks
    #sms_alert_settings = {
    #  sms_alert1 = {
    #   name = "sms_alert_servicehealth"
    #   country_code = "65"
    #   phone_number = "0000000"
    # }
    #}

    #webhook = {
    #  webhook1 = {
    #   name = "webhook_trigger_servicehealth"
    #   service_uri = "https://uri"
    # }
    #}

    arm_role_alert = {
      role_alert1 = {
        name                    = "servicehealth-alerts-contributors"
        use_common_alert_schema = false
        role_name               = "Contributor" #case-sensitive
      }
      role_alert2 = {
        name                    = "servicehealth-alerts-owners"
        use_common_alert_schema = false
        role_name               = "Owner" #case-sensitive
      }
    }
  }
}
