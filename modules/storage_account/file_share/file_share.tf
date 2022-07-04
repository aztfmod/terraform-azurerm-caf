# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share

resource "azurerm_storage_share" "fs" {
  name                 = var.settings.name
  storage_account_name = var.storage_account_name
  quota                = try(var.settings.quota, null)
  metadata             = try(var.settings.metadata, null)
  enabled_protocol     = try(var.settings.enabled_protocol, null)

  dynamic "acl" {
    for_each = try(var.settings.acl, {})
    content {
      id = acl.value.id

      dynamic "access_policy" {
        for_each = try(var.settings.access_policy, {})
        content {
          permissions = access_policy.value.permissions
          start       = try(access_policy.value.start, null)
          expiry      = try(access_policy.value.expiry, null)
        }
      }
    }
  }
}

# Issue open in 2.61 : https://github.com/terraform-providers/terraform-provider-azurerm/issues/11184
resource "azurerm_backup_protected_file_share" "fs_backup" {
  for_each = try(var.settings.backups, null) != null ? toset(["enabled"]) : toset([])

  resource_group_name       = try(var.recovery_vault.resource_group_name, var.resource_group_name)
  recovery_vault_name       = var.recovery_vault.name
  source_storage_account_id = var.storage_account_id
  source_file_share_name    = azurerm_storage_share.fs.name
  backup_policy_id          = var.recovery_vault.backup_policies.file_shares[var.settings.backups.policy_key].id
}
