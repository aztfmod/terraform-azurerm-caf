resource "azurerm_storage_account_local_user" "users" {
  storage_account_id = var.storage_account_id

  for_each             = var.settings.local_users
  name                 = each.value.name
  ssh_key_enabled      = try(each.value.ssh_key_enabled, false)
  ssh_password_enabled = try(each.value.ssh_password_enabled, false)
  home_directory       = try(each.value.home_directory, null)

  dynamic "ssh_authorized_key" {
    for_each = try(each.value.ssh_authorized_key, {})
    content {
      description = each.value.ssh_authorized_key.description
      key         = each.value.ssh_authorized_key.key
    }
  }
  dynamic "permission_scope" {
    for_each = try(each.value.permission_scope, {})
    content {
      permissions {
        read   = try(permission_scope.value.read, false)
        create = try(permission_scope.value.create, false)
        delete = try(permission_scope.value.delete, false)
        list   = try(permission_scope.value.list, false)
        write  = try(permission_scope.value.write, false)
      }
      service       = permission_scope.value.service
      resource_name = permission_scope.value.resource_name
    }
  }
}


resource "azurerm_key_vault_secret" "password" {
  for_each = {
    for key, value in var.settings.local_users : key => value
    if value.ssh_password_enabled == true
  }
  name         = format("sa-%s-password-%s", var.settings.name, each.value.name)
  value        = try(azurerm_storage_account_local_user.users[each.key].password)
  key_vault_id = try(each.value.lz_key, null) == null ? var.remote_objects.keyvaults[var.client_config.landingzone_key][each.value.keyvault.key].id : var.remote_objects.keyvaults[each.value.lz_key][each.value.keyvault.key].id
}