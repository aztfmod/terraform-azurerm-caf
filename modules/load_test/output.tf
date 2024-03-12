output "id" {
  value = azurerm_load_test.this.id
}

output "data_plane_uri" {
  value = azurerm_load_test.this.data_plane_uri
}

output "identity" {
  value = try(azurerm_load_test.this.identity, null)
}
