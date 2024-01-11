output "key_id" {
  value = azuread_service_principal_token_signing_certificate.token_signing_certificate.key_id
}

output "thumbprint" {
  value = azuread_service_principal_token_signing_certificate.token_signing_certificate.thumbprint
}

output "start_date" {
  value = azuread_service_principal_token_signing_certificate.token_signing_certificate.start_date
}

output "value" {
  value = azuread_service_principal_token_signing_certificate.token_signing_certificate.value
}

output "certificate" {
  value = "-----BEGIN CERTIFICATE-----${join("",  [for i, v in split("", azuread_service_principal_token_signing_certificate.token_signing_certificate.value) : i % 76 == 0 ? "\n${v}" : v ])}\n-----END CERTIFICATE-----"
}
