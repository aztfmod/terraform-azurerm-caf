locals {
  # Need to update the storage tags if the environment tag is updated with the rover command line
  tags = try(var.settings.tags, null) == null ? null : try(var.settings.tags.environment, null) == null ? var.settings.tags : merge(lookup(var.settings, "tags", {}), { "environment" : var.global_settings.environment })
}

# naming convention
resource "azurecaf_name" "keyvault" {
  name          = var.settings.name
  resource_type = "azurerm_key_vault"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_key_vault" "keyvault" {

  name                            = azurecaf_name.keyvault.result
  location                        = lookup(var.settings, "region", null) == null ? var.resource_groups[var.settings.resource_group_key].location : var.global_settings.regions[var.settings.region]
  resource_group_name             = var.resource_groups[var.settings.resource_group_key].name
  tenant_id                       = var.client_config.tenant_id
  sku_name                        = try(var.settings.sku_name, "standard")
  tags                            = merge(local.tags, var.base_tags)
  enabled_for_deployment          = try(var.settings.enabled_for_deployment, false)
  enabled_for_disk_encryption     = try(var.settings.enabled_for_disk_encryption, false)
  enabled_for_template_deployment = try(var.settings.enabled_for_template_deployment, false)
  purge_protection_enabled        = try(var.settings.purge_protection_enabled, false)
  soft_delete_enabled             = try(var.settings.soft_delete_enabled, true)
  enable_rbac_authorization       = try(var.settings.enable_rbac_authorization, false)

  dynamic "network_acls" {
    for_each = lookup(var.settings, "network", {})

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
