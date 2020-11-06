
resource "azurecaf_name" "asr_rg_vault" {
  name          = var.settings.name
  resource_type = "azurerm_recovery_services_vault"
  prefixes      = [var.global_settings.prefix]
  random_length = try(var.global_settings.random_length, null)
  clean_input   = true
  passthrough   = try(var.global_settings.passthrough, false)
}

resource "azurerm_recovery_services_vault" "asr_rg_vault" {
  name                = azurecaf_name.asr_rg_vault.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = local.tags

  soft_delete_enabled = try(var.settings.soft_delete_enabled, true)
}