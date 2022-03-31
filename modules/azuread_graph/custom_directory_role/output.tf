output "display_name" {
  value = azuread_custom_directory_role.cusdr.display_name
  description = "The display name of the custom directory role"
}
output "enabled" {
  value = azuread_custom_directory_role.cusdr.enabled
  description = "Indicates whether the role is enabled for assignment"
}
output "permissions" {
  value = azuread_custom_directory_role.cusdr.permissions
  description = "List of permissions that are included in the custom directory role"
}
output "version" {
  value = azuread_custom_directory_role.cusdr.version
  description = "The version of the role definition."
}
output "description" {
  value = azuread_custom_directory_role.cusdr.description
  description = "The description of the custom directory role"
}
output "template_id" {
  value = azuread_custom_directory_role.cusdr.template_id
  description = "Custom template identifier that is typically used if one needs an identifier to be the same across different directories."
}
output "object_id" {
  value = azuread_custom_directory_role.cusdr.object_id
  description = "The object ID of the directory role"
}
