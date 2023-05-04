resource "azurerm_key_vault_certificate" "certificate" {
  name         = var.name
  key_vault_id = var.keyvault_id

  certificate {
    contents = var.contents
    password = try(var.password, null)
  }
}