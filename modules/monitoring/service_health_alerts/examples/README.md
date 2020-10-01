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
  
   monitoring = {
    service_health_alerts = {
        enable_service_health_alerts = true/false
        name = " <name>"
        location = ["location1", "location2"] 
        #add/modify more regions if needed; must be supplied in a List.
        action_group_name = "<name>"
        shortname = "<name>"
        resource_group_key = "<resource group key>"
        
        email_alert_settings = {  
            enable_email_alert = true/false
            name = "<name>"          
            email_address = "<email address>"
            use_common_alert_schema = true/false
        }
        sms_alert_settings = {  
            enable_sms_alert = true/false
            name = "<name>"        
            country_code = "<country code>"
            phone_number = "<phone number>"
            
        }
        webhook = {  
            enable_webhook_trigger = true/false
            name = "<name>          
            service_uri = "https://<uri>"
        }
        arm_role_alert = {
            enable_arm_role_alert = true/false
            name = "<name>"
            #refer https://docs.microsoft.com/en-us/azure/role-based-access-control/ 
            role_id = "b24988ac-6180-42a0-ab88-20f7382dd24c"  #UUID for Contributor Role.  
            use_common_alert_schema = true/false
        }
    
    }
    
}
```

<!--- END_TF_DOCS --->