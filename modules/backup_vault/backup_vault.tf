# locals {
#   # Need to update the storage tags if the environment tag is updated with the rover command line
#   tags = try(var.settings.tags, null) == null ? null : try(var.settings.tags.environment, null) == null ? var.settings.tags : merge(lookup(var.settings, "tags", {}), { "environment" : var.global_settings.environment })
# }

# naming convention
resource "azurecaf_name" "bckp" {
  name          = var.settings.name
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
  datastore_type      = try(var.settings.datastore_type, "VaultStore")
  redundancy          = try(var.settings.redundancy, "LocallyRedundant")
  tags                = try(merge(var.base_tags, local.tags), {})
  
  dynamic "identity" {
    for_each = lookup(var.settings, "enable_identity", false) == false ? [] : [1]

    content {
      type = "SystemAssigned"
    }
  }
}

module "backup_vault_policy" {
  source   = "./backup_vault_policy"
  for_each = try(var.settings.backup_vault_policies, {})

  vault_id = azurerm_data_protection_backup_vault.backup_vault.id
  settings = each.value
}
  
# module "backup_vault_instance" {
#   source   = "./backup_vault_instance"
# #   for_each = try(var.backup_vault.backup_vault_instances, {})
  

#   vault_id           = azurerm_data_protection_backup_vault.backup_vault.id
  
# #   resource_group_name        = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
# #   location                   = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
#   backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy.id
#   storage_account_id = try(var.storage_accounts[try(each.value.storage_account.lz_key, var.client_config.landingzone_key)][each.value.storage_account.key].id, null)
  
#   settings           = each.value
   
# }


  
