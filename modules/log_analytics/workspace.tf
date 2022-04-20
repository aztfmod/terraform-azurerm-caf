# naming convention
resource "azurecaf_name" "law" {
  name          = var.log_analytics.name
  resource_type = "azurerm_log_analytics_workspace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_log_analytics_workspace" "law" {
  name                               = azurecaf_name.law.result
  location                           = var.location
  resource_group_name                = var.resource_group_name
  daily_quota_gb                     = lookup(var.log_analytics, "daily_quota_gb", null)
  internet_ingestion_enabled         = lookup(var.log_analytics, "internet_ingestion_enabled", null)
  internet_query_enabled             = lookup(var.log_analytics, "internet_query_enabled", null)
  reservation_capacity_in_gb_per_day = can(var.log_analytics.reservation_capcity_in_gb_per_day) || can(var.log_analytics.reservation_capacity_in_gb_per_day) ? try(var.log_analytics.reservation_capcity_in_gb_per_day, var.log_analytics.reservation_capacity_in_gb_per_day) : null
  sku                                = lookup(var.log_analytics, "sku", "PerGB2018")
  retention_in_days                  = lookup(var.log_analytics, "retention_in_days", 30)
  tags                               = local.tags
}