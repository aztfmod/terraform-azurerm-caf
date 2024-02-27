resource "azurerm_postgresql_flexible_server_active_directory_administrator" "postgresql" {
  for_each = try(var.settings.authentication.azuread_administrator, {})

  resource_group_name = local.resource_group_name
  server_name         = azurerm_postgresql_flexible_server.postgresql.name
  tenant_id           = can(var.settings.authentication.tenant_id) ? var.settings.authentication.tenant_id : var.client_config.tenant_id
  object_id           = can(each.value.object_id) ? each.value.object_id : (
    each.value.principal_type == "ServicePrincipal" ? var.remote_objects.service_principals[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].object_id :
    each.value.principal_type == "Group" ? var.remote_objects.azuread_groups[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].object_id :
    each.value.principal_type == "User" ? var.remote_objects.azuread_users[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].object_id : null
  )
  principal_name      = each.value.display_name
  principal_type      = each.value.principal_type
}