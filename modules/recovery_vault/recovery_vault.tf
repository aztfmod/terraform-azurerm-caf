# Tested with :  AzureRM version 2.99.0
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
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = "Standard"
  tags                = merge(local.tags, try(var.settings.tags, null))
  soft_delete_enabled = try(var.settings.soft_delete_enabled, true)
  storage_mode_type   = try(var.settings.storage_mode_type, "GeoRedundant")

  identity {
    type = "SystemAssigned"
  }

  dynamic "encryption" {
    for_each = can(var.settings.encryption) ? [1] : []

    content {
      key_id                            = var.settings.encryption.key_id
      infrastructure_encryption_enabled = try(var.settings.encryption.infrastructure_encryption_enabled, true)
      use_system_assigned_identity      = true # only value possible in AzureRM provider 2.99.0
    }
  }
}
