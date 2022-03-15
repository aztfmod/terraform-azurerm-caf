resource "azurecaf_name" "logic_app_standard_name" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_workflow" #No azurecaf name for standard logic apps yet :-/
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_logic_app_standard" "logic_app_standard" {
  name                       = azurecaf_name.logic_app_standard_name.result
  location                   = lookup(var.settings, "region", null) == null ? local.resource_group.location : var.global_settings.regions[var.settings.region]
  resource_group_name        = local.resource_group.name
  app_service_plan_id        = local.app_service_plan.id
  storage_account_name       = local.storage_account.name
  storage_account_access_key = local.storage_account.primary_access_key
}