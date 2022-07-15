output "display_name" {
  value       = azuread_directory_role.dirr.display_name
  description = "The display name of the directory role"
}
output "template_id" {
  value       = azuread_directory_role.dirr.template_id
  description = "The object ID of the template associated with the directory role"
}
output "description" {
  value       = azuread_directory_role.dirr.description
  description = "The description of the directory role"
}
output "object_id" {
  value       = azuread_directory_role.dirr.object_id
  description = "The object ID of the directory role"
}
