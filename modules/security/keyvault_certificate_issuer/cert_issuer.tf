resource "azurerm_key_vault_certificate_issuer" "keycertisr" {
  name          =  try(var.settings.issuer_name, null)
  key_vault_id  =  var.keyvault_id
  provider_name =  try(var.settings.provider_name, null)
  org_id        = try(var.settings.organization_id, null)
  account_id    = try(var.settings.account_id, null)
  password      = var.password
  
  

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

# locals {
#   cert_password     = try(data.azurerm_key_vault_secret.cert_password_key.0.value, null)
# }

# data "azurerm_key_vault_secret" "cert_password_key" {
#   count        = try(var.settings.cert_password_key, null) == null ? 0 : 1
#   name         = var.settings.cert_password_key
#   key_vault_id = var.keyvault_id
# }

# data external cert_password_key {
#   count        = try(var.settings.cert_password_key, null) == null ? 0 : 1
#   program = [
#     "bash", "-c", 
#     format(
#       "az keyvault secret show -n '%s' --vault-name '%s' --query '{value: value }' -o json", 
#       var.settings.cert_password_key, 
#       var.keyvault.name
#     )
#   ]
# }

