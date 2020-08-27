data "azuread_users" "users" {
  user_principal_names = lookup(var.azuread_groups.members, "user_principal_names", [])
}

locals {
  member_ids = toset(
    concat(
      data.azuread_users.users.object_ids,
      try(var.azuread_groups.members.object_ids, [])
    )
  )

}

resource "azuread_group_member" "member" {
  for_each         = local.member_ids
  group_object_id  = azuread_group.group.id
  member_object_id = each.value
}