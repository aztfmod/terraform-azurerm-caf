resource "azurecaf_naming_convention" "law" {
  name          = var.log_analytics.name
  prefix        = var.global_settings.prefix
  resource_type = "azurerm_log_analytics_workspace"
  convention    = var.global_settings.convention
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = azurecaf_naming_convention.law.result
  location            = var.global_settings.regions[var.log_analytics.region]
  resource_group_name = var.resource_groups[var.log_analytics.resource_group_key].name
  sku                 = lookup(var.log_analytics, "sku", "PerGB2018")
  retention_in_days   = lookup(var.log_analytics, "retention_in_days", 30)
  tags                = lookup(var.log_analytics, "tags", {})
}