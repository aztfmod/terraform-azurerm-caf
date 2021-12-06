locals {
  # Need to update the storage tags if the environment tag is updated with the rover command line
  tags = try(var.backup_vault.tags, null) == null ? null : try(var.backup_vault.tags.environment, null) == null ? var.backup_vault.tags : merge(lookup(var.backup_vault, "tags", {}), { "environment" : var.global_settings.environment })
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
  tags                = try(merge(var.base_tags, local.tags), {})
  
  dynamic "identity" {
    for_each = lookup(var.backup_vault, "enable_identity", false) == false ? [] : [1]

    content {
      type = "SystemAssigned"
    }
  }
}

module "backup_vault_policy" {
  source   = "./backup_vault_policy"
  for_each = try(var.backup_vault.backup_vault_policies, {})

  vault_id = azurerm_data_protection_backup_vault.backup_vault.id
  settings = each.value
}
  
module "backup_vault_instance" {
  source   = "./backup_vault_instance"
  for_each = try(var.backup_vault.backup_vault_instances, {})

  vault_id           = azurerm_data_protection_backup_vault.backup_vault.id
#   location           = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
    location = coalesce(
    try(local.global_settings.regions[each.value.region], null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group_key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].location, null)
  )
  storage_account_id = "/subscriptions/3f4dae7c-7085-45cc-a974-39c13903344c/resourceGroups/qs-rg-launchpad-level0-gdj/providers/Microsoft.Storage/storageAccounts/qsstlevel0skk"
  backup_policy_id   = "/subscriptions/3f4dae7c-7085-45cc-a974-39c13903344c/resourceGroups/qs-rg-launchpad-level0-gdj/providers/Microsoft.DataProtection/backupVaults/qs-bckp-level0-gvp/backupPolicies/back-policy"
  settings           = each.value
}
  
