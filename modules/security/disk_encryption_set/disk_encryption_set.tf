resource "azurerm_disk_encryption_set" "encryption_set" {
  name                = var.settings.name
  resource_group_name = var.resource_groups[var.settings.resource_group_key].name
  location            = lookup(var.settings, "region", null) == null ? var.resource_groups[var.settings.resource_group_key].location : var.global_settings.regions[var.settings.region]
  key_vault_key_id    = var.key_vault_key_ids[var.settings.key_vault_key_key].id

  identity {
    type = "SystemAssigned"
  }
  tags = merge(var.base_tags, try(var.settings.tags, null))
}