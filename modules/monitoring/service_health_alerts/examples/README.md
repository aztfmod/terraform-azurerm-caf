[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-azure-firewall&repo=terraform-azurerm-caf-azure-firewall)
[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Deploys Service Health Alerts
This module tracks the following types of health events (subscription wide) and send alerts:

1. Service issues - Problems in the Azure services that affect you right now.

2. Planned maintenance - Upcoming maintenance that can affect the availability of your services in the future.

3. Health advisories - Changes in Azure services that require your attention. 

4. Security advisories - Security related notifications or violations that may affect the availability of your Azure services.

Ref : https://docs.microsoft.com/en-us/azure/service-health/service-health-overview

An Action Group will be created and your choice of Notifications type can be chosen dynamically (refer input syntax). 
Due to the some limitations, Service Health Alerts are being created using an ARM Template and is embedded within the Terraform script.




## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

##  Input Syntax
```hcl
  # refer example configuration file
   monitoring = {
    service_health_alerts = {
        enable_service_health_alerts = true/false
        name = "<string>"
        location = ["region1", "region2"] 
        #add/modify more regions if needed; must be supplied in a List.
        action_group_name = "<string>"
        shortname = "<string>"
        resource_group_key = "<string>"
        
        email_alert_settings = [
          {
            name = "<string>"        
            email_address = "<emailAddress>"
            use_common_alert_schema = true/false
          },
          #remove the below block if more email addresses need not to be added
          {
            name = "<string>"          
            email_address = "email@domain2"
            use_common_alert_schema = true/false
          }
          #keep expanding this block to add more email addresses
        ]
            
        sms_alert_settings = [
          # { #comment out this block exclude this configuration completely
          #   name = "<string>"       
          #   country_code ="<countryCode>"
          #   phone_number = "<phoneNumber>"
          # } #follow the syntax of email alert settings to have one or more alerts
        ]

        webhook = [
          # { #comment out this block exclude this configuration
          #   name = "<string>"         
          #   service_uri = "<URI>"
          # } #follow the syntax of email alert settings to have one or more alerts
        ]

        arm_role_alert = [
          {
            name = "<string>"          
            # refer https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
            role_id = "b24988ac-6180-42a0-ab88-20f7382dd24c"  #UUID for Contributor Role
            use_common_alert_schema = false
          } #follow the syntax of email alert settings to have one or more alerts
        ]

    
    }
    
}
    
}
```

<!--- END_TF_DOCS --->
