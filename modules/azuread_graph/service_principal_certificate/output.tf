output "service_principal_id" {
  value       = azuread_service_principal_certificate.serpc.service_principal_id
  description = "The object ID of the service principal for which this certificate should be created"
}
output "key_id" {
  value       = azuread_service_principal_certificate.serpc.key_id
  description = "A UUID used to uniquely identify this certificate. If not specified a UUID will be automatically generated"
}
output "encoding" {
  value       = azuread_service_principal_certificate.serpc.encoding
  description = "Specifies the encoding used for the supplied certificate data"
}
output "start_date" {
  value       = azuread_service_principal_certificate.serpc.start_date
  description = "The start date from which the certificate is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). If this isn't specified, the current date is used"
}
output "end_date" {
  value       = azuread_service_principal_certificate.serpc.end_date
  description = "The end date until which the certificate is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`)"
}
output "end_date_relative" {
  value       = azuread_service_principal_certificate.serpc.end_date_relative
  description = "A relative duration for which the certificate is valid until, for example `240h` (10 days) or `2400h30m`. Valid time units are \\ns\\, \\us\\ (or \\�s\\), \\ms\\, \\s\\, \\m\\, \\h\\"
}
output "type" {
  value       = azuread_service_principal_certificate.serpc.type
  description = "The type of key/certificate"
}
