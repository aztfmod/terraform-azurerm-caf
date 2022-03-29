output "name" {
  value = var.settings.display_name
}

output "rbac_id" {
  value = data.azuread_group.group.id
}

output "id" {
  value = data.azuread_group.group.id
}