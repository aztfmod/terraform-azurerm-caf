# resource "azurecaf_name" "keycertisr" {
#   name          = var.settings.name
#   resource_type = "azurerm_key_vault_certificate_issuer"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }


resource "azurerm_key_vault_certificate_issuer" "keycertisr" {
  name          =  var.issuer_name
  org_id        =  var.org_id
  key_vault_id  =  var.keyvault_id
  provider_name =  var.provider_name
  account_id    =  var.account_id
  password      = "example-password"
}

