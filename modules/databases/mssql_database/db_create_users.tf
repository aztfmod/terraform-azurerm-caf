data "azurerm_key_vault_secret" "sql_admin_password" {
  count        = try(var.settings.sql_users, null) == null ? 0 : 1
  name         = can(var.settings.keyvault_secret_name) ? var.settings.keyvault_secret_name : format("%s-password", var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].name)
  key_vault_id = try(var.keyvault_id, null)
}

resource "null_resource" "create_sql_user" {
  depends_on = [azurerm_mssql_database.mssqldb]
  for_each   = try(var.settings.sql_users, {})

  provisioner "local-exec" {
    interpreter = ["/bin/bash"]
    on_failure  = fail
    command     = format("%s/scripts/create_sql_user.sh", path.module)

    environment = {
      SQLCMDSERVER = local.server_name
      SQLCMDDBNAME = azurerm_mssql_database.mssqldb.name
      DBADMINUSER  = var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].administrator_login
      DBADMINPWD   = data.azurerm_key_vault_secret.sql_admin_password[0].value
      DBUSERNAMES  = each.value.name
      DBROLES      = each.value.role

      DBUSERPASSWORDS  = azurerm_key_vault_secret.sql_user_password[each.key].value
      SQLLOGINFILEPATH = format("%s/scripts/create_sql_login.sql", path.module)
      SQLUSERFILEPATH  = format("%s/scripts/create_sql_user.sql", path.module)
    }
  }
}

resource "null_resource" "delete_sql_user" {
  depends_on = [azurerm_mssql_database.mssqldb]
  for_each   = try(var.settings.sql_users, {})

  triggers = {
    sql_server_name    = local.server_name
    sql_server_db_name = azurerm_mssql_database.mssqldb.name
    db_admin_user      = var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].administrator_login
    db_admin_password  = data.azurerm_key_vault_secret.sql_admin_password[0].value
    db_user_name       = each.value.name
    sql_login_filepath = format("%s/scripts/delete_sql_login.sql", path.module)
    sql_user_filepath  = format("%s/scripts/delete_sql_user.sql", path.module)
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash"]
    when        = destroy
    command     = format("%s/scripts/delete_sql_user.sh", path.module)

    on_failure = fail

    environment = {
      SQLCMDSERVER     = self.triggers.sql_server_name
      SQLCMDDBNAME     = self.triggers.sql_server_db_name
      DBADMINUSER      = self.triggers.db_admin_user
      DBADMINPWD       = self.triggers.db_admin_password
      DBUSERNAMES      = self.triggers.db_user_name
      SQLLOGINFILEPATH = self.triggers.sql_login_filepath
      SQLUSERFILEPATH  = self.triggers.sql_user_filepath
    }
  }
}

resource "random_password" "sql_user" {
  for_each = try(var.settings.sql_users, {})

  length           = 128
  special          = true
  upper            = true
  numeric          = true
  override_special = "$#%"
}

resource "azurerm_key_vault_secret" "sql_user_password" {
  for_each = try(var.settings.sql_users, {})

  name         = format("%s-%s-password", azurecaf_name.mssqldb.result, each.key)
  value        = random_password.sql_user[each.key].result
  key_vault_id = try(var.keyvault_id, null)

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
