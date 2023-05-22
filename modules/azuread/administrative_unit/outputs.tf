output "display_name" {
  value       = azuread_administrative_unit.admu.display_name
  description = "The display name for the administrative unit"
}
output "description" {
  value       = azuread_administrative_unit.admu.description
  description = "The description for the administrative unit"
}
output "members" {
  value       = azuread_administrative_unit.admu.members
  description = "A set of object IDs of members who should be present in this administrative unit. Supported object types are Users or Groups"
}
output "prevent_duplicate_names" {
  value       = azuread_administrative_unit.admu.prevent_duplicate_names
  description = "If `true`, will return an error if an existing administrative unit is found with the same name"
}
output "object_id" {
  value       = azuread_administrative_unit.admu.object_id
  description = "The object ID of the administrative unit"
}