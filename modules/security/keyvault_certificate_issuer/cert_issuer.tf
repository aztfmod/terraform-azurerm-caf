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
  key_vault_id  =  var.keyvault_id
  provider_name =  var.provider_name
  org_id        = try(var.settings.organization_id, null)
  account_id    = try(var.settings.account_id, null)
  password      = "example-password"

  
    

  dynamic "admin" {
    for_each = try(var.settings.admin_settings, {})
    content {
      email_address                 = admin.value.email_address
      first_name                    = admin.value.first_name
      last_name                     = admin.value.last_name
      phone                         = admin.value.phone_number
    }

  }
  
}

