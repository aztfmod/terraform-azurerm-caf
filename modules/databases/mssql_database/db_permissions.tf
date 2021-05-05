resource "null_resource" "set_db_permissions" {
  for_each = local.db_permissions

  triggers = {
    db_usernames = join(",", each.value.db_usernames)
    db_roles     = join(",", each.value.db_roles)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_db_permissions.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      SQLCMDSERVER = local.server_name
      SQLCMDDBNAME = azurerm_mssql_database.mssqldb.name
      DBUSERNAMES  = format("'%s'", join(",", each.value.db_usernames))
      DBROLES      = format("'%s'", join(",", each.value.db_roles))
      SQLFILEPATH  = format("%s/scripts/set_db_permissions.sql", path.module)
    }
  }

}