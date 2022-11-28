output "name" {
  value = var.settings.name
}

output "location" {
  value = data.azurerm_resource_group.rg.location
}

output "tags" {
  value = data.azurerm_resource_group.rg.tags

}

output "rbac_id" {
  value = data.azurerm_resource_group.rg.id
}

output "id" {
  value = data.azurerm_resource_group.rg.id
}