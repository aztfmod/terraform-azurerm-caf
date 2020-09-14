resource "azurecaf_naming_convention" "appis" {
  name          = var.name
  prefix        = var.prefix
  resource_type = "azurerm_application_insights"
  # convention    = var.convention
  # max_length    = var.max_length
}

resource "azurerm_application_insights" "appinsights" {
  name                                  = azurecaf_naming_convention.appis.result
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  application_type                      = var.application_type
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage
  disable_ip_masking                    = var.disable_ip_masking
}