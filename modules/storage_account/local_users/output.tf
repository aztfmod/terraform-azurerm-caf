output "local_user" {
  value = {
    for key, value in try(var.local_users, {}) : key => {
      id       = azurerm_storage_account_local_user.users[key].id
      password = azurerm_storage_account_local_user.users[key].password
      sid      = azurerm_storage_account_local_user.users[key].sid
    }
  }
}
