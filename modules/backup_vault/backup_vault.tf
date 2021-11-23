locals {
  # Need to update the storage tags if the environment tag is updated with the rover command line
  tags = lookup(var.backup_vault, "tags", null) == null ? null : lookup(var.backup_vault.tags, "environment", null) == null ? var.backup_vault.tags : merge(lookup(var.backup_vault, "tags", {}), { "environment" : var.global_settings.environment })
}

# naming convention
resource "azurecaf_name" "bckp" {
  name          = var.backup_vault.name
  resource_type = "azurerm_recovery_services_vault"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = false #var.global_settings.use_slug
}

resource "azurerm_data_protection_backup_vault" "backup_vault" {
  name                = azurecaf_name.bckp.result 
  location            = var.location
  resource_group_name = var.resource_group_name
  datastore_type      = try(var.backup_vault.datastore_type, "VaultStore")
  redundancy          = try(var.backup_vault.redundancy, "LocallyRedundant")
  tags                = merge(var.base_tags, local.tags)
  
  dynamic "identity" {
    for_each = lookup(var.backup_vault, "enable_identity", false) == false ? [] : [1]

    content {
      type = "SystemAssigned"
    }
  }
#   identity {
#     type = "SystemAssigned"
#   }
  
}
