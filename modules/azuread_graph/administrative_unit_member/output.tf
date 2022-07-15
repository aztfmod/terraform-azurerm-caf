output "administrative_unit_object_id" {
  value       = azuread_administrative_unit_member.admum.administrative_unit_object_id
  description = "The object ID of the administrative unit"
}
output "member_object_id" {
  value       = azuread_administrative_unit_member.admum.member_object_id
  description = "The object ID of the member"
}
