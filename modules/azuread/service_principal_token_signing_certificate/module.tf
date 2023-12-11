
resource "azuread_service_principal_token_signing_certificate" "token_signing_certificate" {
  service_principal_id = var.service_principal_id
  display_name         = try(var.settings.display_name, null)
  end_date             = try(var.settings.end_date, null)
}

