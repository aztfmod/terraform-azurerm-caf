# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault

resource "azurecaf_name" "asr_rg_vault" {
  name          = var.settings.name
  resource_type = "azurerm_recovery_services_vault"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_recovery_services_vault" "asr" {
  name                = azurecaf_name.asr_rg_vault.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = local.tags
  soft_delete_enabled = try(var.settings.soft_delete_enabled, true)

  identity {
    type = "SystemAssigned"
  }

}
