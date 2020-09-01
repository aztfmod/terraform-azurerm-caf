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
  location                        = try(var.global_settings.regions[var.keyvault.region], var.resource_groups[var.keyvault.resource_group_key].location)
  resource_group_name             = var.resource_groups[var.keyvault.resource_group_key].name
  tenant_id                       = var.tenant_id
  sku_name                        = try(var.keyvault.sku_name, "standard")
  tags                            = local.tags
  enabled_for_deployment          = try(var.keyvault.enabled_for_deployment, false)
  enabled_for_disk_encryption     = try(var.keyvault.enabled_for_disk_encryption, false)
  enabled_for_template_deployment = try(var.keyvault.enabled_for_template_deployment, false)
  purge_protection_enabled        = try(var.keyvault.purge_protection_enabled, false)
  soft_delete_enabled             = try(var.keyvault.soft_delete_enabled, true)

  dynamic "network_acls" {
    for_each = lookup(var.keyvault, "network", {})

    content {
      bypass         = network_acls.value.bypass
      default_action = try(network_acls.value.default_action, "Deny")
      ip_rules       = try(network_acls.value.ip_rules, null)
      virtual_network_subnet_ids = [
        for subnet_key in network_acls.value.subnet_keys : var.vnets[network_acls.key].subnets[subnet_key].id
      ]
    }
  }
}
