locals {
  # Need to update the storage tags if the environment tag is updated with the rover command line
  tags = try(var.keyvault.tags, null) == null ? null : try(var.keyvault.tags.environment, null) == null ? var.keyvault.tags : merge(lookup(var.keyvault, "tags", {}), { "environment" : var.global_settings.environment })
}

resource "azurecaf_naming_convention" "keyvault" {
  name          = var.keyvault.name
  resource_type = "kv"
  convention    = try(var.keyvault.location, var.global_settings.convention)
  prefix        = lookup(var.keyvault, "useprefix", false) == true ? var.global_settings.prefix_start_alpha : ""
  max_length    = try(var.keyvault.max_length, null)
}

resource "azurerm_key_vault" "keyvault" {

  name                            = azurecaf_naming_convention.keyvault.result
  location                        = var.global_settings.regions[try(var.keyvault.region, var.resource_groups[var.keyvault.resource_group_key].location)]
  resource_group_name             = var.resource_groups[var.keyvault.resource_group_key].name
  tenant_id                       = var.tenant_id
  sku_name                        = var.keyvault.sku_name
  tags                            = local.tags
  enabled_for_deployment          = try(var.keyvault.enabled_for_deployment, false)
  enabled_for_disk_encryption     = try(var.keyvault.enabled_for_disk_encryption, false)
  enabled_for_template_deployment = try(var.keyvault.enabled_for_template_deployment, false)
  purge_protection_enabled        = try(var.keyvault.purge_protection_enabled, false)
  soft_delete_enabled             = try(var.keyvault.soft_delete_enabled, true)

}
