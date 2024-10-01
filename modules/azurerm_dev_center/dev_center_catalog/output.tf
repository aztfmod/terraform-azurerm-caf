output "dev_center_catalog_id" {
  description = "The ID of the Dev Center Catalog."
  value       = azurerm_dev_center_catalog.dev_center_catalog.id
}

output "dev_center_catalog_name" {
  description = "The name of the Dev Center Catalog."
  value       = azurerm_dev_center_catalog.dev_center_catalog.name
}

output "dev_center_catalog_location" {
  description = "The location of the Dev Center Catalog."
  value       = azurerm_dev_center_catalog.dev_center_catalog.location
}

output "dev_center_catalog_resource_group_name" {
  description = "The name of the resource group containing the Dev Center Catalog."
  value       = azurerm_dev_center_catalog.dev_center_catalog.resource_group_name
}
