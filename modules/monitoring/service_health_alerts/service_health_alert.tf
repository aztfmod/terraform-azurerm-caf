resource "azurecaf_name" "ag1_name" {  
  name    = var.settings.action_group_name
  prefixes      = [var.global_settings.prefix]
  resource_type    = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurecaf_name" "service_health_alert_name" {  
  name    = var.settings.name
  prefixes      = [var.global_settings.prefix]
  resource_type    = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurecaf_name" "email_alert_name" {  
  name    = var.settings.email_alert_settings.name
  prefixes      = [var.global_settings.prefix]
  resource_type    = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurecaf_name" "sms_alert_name" {  
  name    = var.settings.sms_alert_settings.name
  prefixes      = [var.global_settings.prefix]
  resource_type    = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurecaf_name" "webhook_trigger_name" {  
  name    = var.settings.webhook.name
  prefixes      = [var.global_settings.prefix]
  resource_type    = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurecaf_name" "arm_role_alert_name" {  
  name    = var.settings.arm_role_alert.name
  prefixes      = [var.global_settings.prefix]
  resource_type    = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "random_string" "random1" {
  length = 16
  special = false
  
}
resource "azurerm_monitor_action_group" "ag1" {
  name                = azurecaf_name.ag1_name.result
  resource_group_name = var.resource_group_name
  short_name          = var.settings.shortname
  enabled = var.settings.enable_service_health_alerts

  dynamic "email_receiver" {
  for_each = var.settings.email_alert_settings.enable_email_alert == false ? [] : [1]
  content {
    name = azurecaf_name.email_alert_name.result
    email_address  = var.settings.email_alert_settings.email_address
    use_common_alert_schema = var.settings.email_alert_settings.use_common_alert_schema
   }
  }

  dynamic "sms_receiver" {
  for_each = var.settings.sms_alert_settings.enable_sms_alert == false? [] : [1]
  content {
    name = azurecaf_name.sms_alert_name.result
    country_code = var.settings.sms_alert_settings.country_code
    phone_number = var.settings.sms_alert_settings.phone_number
   }
  }

  dynamic "webhook_receiver" {
  for_each = var.settings.webhook.enable_webhook_trigger == false ? [] : [1]
  content {
    name = azurecaf_name.webhook_trigger_name.result
    service_uri = var.settings.webhook.service_uri
    }
  }

  dynamic "arm_role_receiver" {
  for_each = var.settings.arm_role_alert.enable_arm_role_alert == false ? [] : [1]
  content {
    name = azurecaf_name.arm_role_alert_name.result
    role_id = var.settings.arm_role_alert.role_id
    use_common_alert_schema = var.settings.arm_role_alert.use_common_alert_schema
   }
  }

} 

resource "azurerm_template_deployment" "alert1" {
  name                = random_string.random1.result
  resource_group_name = var.resource_group_name

  template_body = file("${path.module}/alert-servicehealth.json")
  parameters = {
    "name"              = azurecaf_name.service_health_alert_name.result
    "actionGroups_name" = azurerm_monitor_action_group.ag1.name
    "region"            = "${join(",", var.settings.location)}"
  }
  deployment_mode = "Incremental"
}
