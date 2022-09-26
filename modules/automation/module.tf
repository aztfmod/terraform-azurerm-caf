
resource "azurecaf_name" "auto_account" {
  name          = var.settings.name
  resource_type = "azurerm_automation_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "automation_schedule" {
  name          = var.settings.name
  resource_type = "azurerm_automation_schedule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_automation_account" "auto_account" {
  name                          = azurecaf_name.auto_account.result
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tags                          = try(local.tags, {})
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  sku_name                      = "Basic" #only Basic is supported at this time.

  dynamic "identity" {
    for_each = try(var.settings.identity, null) == null ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = local.managed_identities
    }
  }
}

resource "azurerm_automation_schedule" "automation_schedule" {
  name                    = azurecaf_name.automation_schedule.result
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.auto_account.name
  frequency               = try(var.automation_schedule.frequency,"Week")
  interval                = var.automation_schedule.interval
  timezone                = var.automation_schedule.timezone
  start_time              = "2014-04-15T18:00:15+02:00"
  description             = var.automation_schedule.description
  week_days               = ["Friday"]
}

