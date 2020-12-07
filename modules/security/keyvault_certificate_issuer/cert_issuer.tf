resource "azurerm_key_vault_certificate_issuer" "keycertisr" {
  name          =  var.issuer_name
  key_vault_id  =  var.keyvault_id
  provider_name =  var.provider_name
  org_id        = try(var.settings.organization_id, null)
  account_id    = try(var.settings.account_id, null)
  password      = azurerm_key_vault_secret.cert_password.value 

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

resource "azurerm_key_vault_secret" "cert_password" {
  name         = "certpassword"
  value        = var.settings.cert_issuer_password
  key_vault_id = var.keyvault_id
}

