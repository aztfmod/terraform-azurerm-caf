output "id" {
  description = "The ID of the File Share"
  value       = azurerm_storage_share.fs.id
}

output "name" {
  description = "The URL of the File Share"
  value       = azurerm_storage_share.fs.name
}

output "url" {
  description = "The URL of the File Share"
  value       = azurerm_storage_share.fs.url
}

output "resource_manager_id" {
  description = "The Resource Manager ID of this File Share"
  value       = azurerm_storage_share.fs.resource_manager_id
}

output "file_share_directories" {
  description = "Output of directories in the file share"
  value       = module.file_share_directory
}