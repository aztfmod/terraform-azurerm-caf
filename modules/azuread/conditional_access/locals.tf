locals {
  module_output = azuread_conditional_access_policy.conditional_access_policy
}

data "azuread_user" "included_users" {
  for_each = toset(try(local.included_user_upns, []))
  user_principal_name = each.value
}

locals {
  included_user_ids      = [for u in var.conditions.users.included_users : u if try(regex("[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", u), null) != null]
  included_user_upns     = setsubtract(setsubtract(var.conditions.users.included_users, [
    "None", "All", "GuestsOrExternalUsers"
  ]), local.included_user_ids)
  included_users_special = sort(setsubtract(var.conditions.users.included_users, setsubtract(var.conditions.users.included_users, [
    "None", "All", "GuestsOrExternalUsers"
  ])))
  included_users = concat([for u in local.included_user_upns : data.azuread_user.included_users[u].object_id], local.included_user_ids, local.included_users_special)
}

data "azuread_user" "excluded_users" {
  for_each = toset(try(local.excluded_user_upns, []))
  user_principal_name = each.value
}

locals {
  excluded_user_ids = [ for u in var.conditions.users.excluded_users : u if try(regex("[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", u), null) != null]
  excluded_user_upns = setsubtract(setsubtract(var.conditions.users.excluded_users, [
    "None", "All", "GuestsOrExternalUsers"
  ]), local.excluded_user_ids)
  excluded_users = concat([for u in local.excluded_user_upns: data.azuread_user.excluded_users[u].object_id], local.excluded_user_ids)
}

data "azuread_groups" "included_groups" {
  display_names = try(local.included_group_names, [])
}

locals {
  included_group_ids = [ for g in var.conditions.users.included_groups : g if try(regex("[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", g), null) != null]
  included_group_names = setsubtract(var.conditions.users.included_groups, local.included_group_ids)
  included_groups = concat(data.azuread_groups.included_groups.object_ids, local.included_group_ids)
}

data "azuread_groups" "excluded_groups" {
  display_names = try(local.excluded_group_names, [])
}

locals {
  excluded_group_ids = [ for g in var.conditions.users.excluded_groups : g if try(regex("[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", g), null) != null]
  excluded_group_names = setsubtract(var.conditions.users.excluded_groups, local.excluded_group_ids)
  excluded_groups = concat(data.azuread_groups.excluded_groups.object_ids, local.excluded_group_ids)
}

