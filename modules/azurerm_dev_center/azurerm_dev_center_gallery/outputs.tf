output "dev_center_gallery_id" {
  description = "The ID of the Dev Center Gallery."
  value       = azurerm_dev_center_gallery.dev_center_gallery.id
}

output "dev_center_gallery_name" {
  description = "The name of the Dev Center Gallery."
  value       = azurerm_dev_center_gallery.dev_center_gallery.name
}

output "dev_center_gallery_location" {
  description = "The location of the Dev Center Gallery."
  value       = azurerm_dev_center_gallery.dev_center_gallery.location
}

output "dev_center_gallery_resource_group_name" {
  description = "The name of the resource group containing the Dev Center Gallery."
  value       = azurerm_dev_center_gallery.dev_center_gallery.resource_group_name
}
