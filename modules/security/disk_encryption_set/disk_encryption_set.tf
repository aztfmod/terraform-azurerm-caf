# Last updated with :  AzureRM version 2.88.1
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/disk_encryption_set

resource "azurerm_disk_encryption_set" "encryption_set" {
  name                      = var.settings.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  key_vault_key_id          = var.key_vault_key_id
  auto_key_rotation_enabled = try(var.settings.auto_key_rotation_enabled, null)
  encryption_type           = try(var.settings.encryption_type, null)

  identity {
    type = "SystemAssigned"
  }
  tags = merge(var.base_tags, try(var.settings.tags, null))
}