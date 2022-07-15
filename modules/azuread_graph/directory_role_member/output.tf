output "role_object_id" {
  value       = azuread_directory_role_member.dirrm.role_object_id
  description = "The object ID of the directory role"
}
output "member_object_id" {
  value       = azuread_directory_role_member.dirrm.member_object_id
  description = "The object ID of the member"
}
