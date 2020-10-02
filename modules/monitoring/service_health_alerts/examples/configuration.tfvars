level = "level2"

landingzone_name = "shared_services"

resource_groups = {
  primary = {
    name = "asr-sg"
  }
  secondary = {
    name = "asr-hk"
  }
}

tfstates = {
  caf_foundations = {
    tfstate = "caf_foundations.tfstate"
  }
  networking = {
     tfstate = "caf_foundations.tfstate"
  }
}



monitoring = {
    service_health_alerts = {
        enable_service_health_alerts = true
        name = "service-health-alert"
        location = ["Southeast Asia", "East Asia"] #add/modify more regions if needed; must be supplied in a List.
        action_group_name = "ag_servicehealth"
        shortname = "HealthAlerts"
        resource_group_key = "primary"
        
        email_alert_settings = [
          {
            enable_email_alerts = true
            name = "email_alert_servicehealth"          
            email_address = "email@domain"
            use_common_alert_schema = false
          },
          {
            enable_email_alerts = true
            name = "email_alert_servicehealth1"          
            email_address = "email@domain2"
            use_common_alert_schema = false
          }
        ]

        sms_alert_settings = [
          # {
          #   name = "sms_alert_servicehealth"          
          #   country_code = "65"
          #   phone_number = "0000000"
          # }
        ]

        webhook = [
          # {
          #   name = "webhook_trigger_servicehealth"          
          #   service_uri = "https://uri"
          # }
        ]

        arm_role_alert = [
          {
            name = "arm_role_alert_servicehealth"          
            # refer https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
            role_id = "b24988ac-6180-42a0-ab88-20f7382dd24c"  #UUID for Contributor Role
            use_common_alert_schema = false
          }
        ]

    
    }
    
}
