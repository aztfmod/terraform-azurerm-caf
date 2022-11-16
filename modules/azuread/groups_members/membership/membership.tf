resource "azuread_group_member" "ids" {
  for_each = var.azuread_service_principals != {} ? toset(try(var.members.keys, [])) : []

  group_object_id  = var.group_object_id
  member_object_id = var.azuread_service_principals[each.key].object_id
}

resource "azuread_group_member" "msi_ids" {
  for_each = var.managed_identities != {} ? toset(try(var.members.keys, [])) : []

  group_object_id  = var.group_object_id
  member_object_id = var.managed_identities[each.key].principal_id
}

resource "azuread_group_member" "mssql_server_ids" {
  for_each = var.mssql_servers != {} ? toset(try(var.members.keys, [])) : []

  group_object_id  = var.group_object_id
  member_object_id = var.mssql_servers[each.key].rbac_id
}