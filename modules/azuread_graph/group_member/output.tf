output "group_object_id" {
  value = azuread_group_member.grom.group_object_id
  description = "The object ID of the group you want to add the member to"
}
output "member_object_id" {
  value = azuread_group_member.grom.member_object_id
  description = "The object ID of the principal you want to add as a member to the group. Supported object types are Users, Groups or Service Principals"
}
