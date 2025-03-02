locals {
  # Need to update the storage tags if the environment tag is updated with the rover command line
  caf_tags = can(var.settings.tags.caf_environment) || can(var.settings.tags.environment) ? merge(lookup(var.settings, "tags", {}), { "caf_environment" : var.global_settings.environment }) : {}
}

# naming convention
resource "azurecaf_name" "keyvault" {
  name          = var.settings.name
  resource_type = "azurerm_key_vault"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = can(var.settings.global_settings.passthrough) ? var.settings.global_settings.passthrough : var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_key_vault" "keyvault" {

  name                            = azurecaf_name.keyvault.result
  location                        = local.location
  resource_group_name             = local.resource_group_name
  tenant_id                       = var.client_config.tenant_id
  sku_name                        = try(var.settings.sku_name, "standard")
  tags                            = merge(local.tags, try(var.settings.tags, null), local.caf_tags)
  enabled_for_deployment          = try(var.settings.enabled_for_deployment, false)
  enabled_for_disk_encryption     = try(var.settings.enabled_for_disk_encryption, false)
  enabled_for_template_deployment = try(var.settings.enabled_for_template_deployment, false)
  purge_protection_enabled        = try(var.settings.purge_protection_enabled, false)
  soft_delete_retention_days      = try(var.settings.soft_delete_retention_days, 7)
  enable_rbac_authorization       = try(var.settings.enable_rbac_authorization, false)
  public_network_access_enabled   = try(var.settings.public_network_access_enabled, null)
  timeouts {
    delete = "60m"

  }

  dynamic "network_acls" {
    for_each = lookup(var.settings, "network", null) == null ? [] : [1]

    content {
      bypass         = var.settings.network.bypass
      default_action = try(var.settings.network.default_action, "Deny")
      ip_rules       = try(var.settings.network.ip_rules, null)
      virtual_network_subnet_ids = try(var.settings.network.subnets, null) == null ? null : [
        for key, value in var.settings.network.subnets : can(value.subnet_id) ? value.subnet_id : var.vnets[try(value.lz_key, var.client_config.landingzone_key)][value.vnet_key].subnets[value.subnet_key].id
      ]
    }
  }

  dynamic "contact" {
    for_each = lookup(var.settings, "contacts", {})

    content {
      email = contact.value.email
      name  = try(contact.value.name, null)
      phone = try(contact.value.phone, null)
    }
  }

  lifecycle {
    ignore_changes = [
      resource_group_name, location
    ]
  }
}
