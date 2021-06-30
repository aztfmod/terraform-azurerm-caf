resource "azuread_group_member" "ids" {
  for_each = toset(try(var.members.keys, []))

  group_object_id  = var.group_object_id
  member_object_id = var.azuread_service_principals[each.key].object_id
}