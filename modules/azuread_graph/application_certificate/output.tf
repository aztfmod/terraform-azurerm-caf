output "application_object_id" {
  value = azuread_application_certificate.appc.application_object_id
  description = "The object ID of the application for which this certificate should be created"
}
output "encoding" {
  value = azuread_application_certificate.appc.encoding
  description = "Specifies the encoding used for the supplied certificate data"
}
output "key_id" {
  value = azuread_application_certificate.appc.key_id
  description = "A UUID used to uniquely identify this certificate. If omitted, a random UUID will be automatically generated"
}
output "start_date" {
  value = azuread_application_certificate.appc.start_date
  description = "The start date from which the certificate is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). If this isn't specified, the current date and time are use"
}
output "end_date" {
  value = azuread_application_certificate.appc.end_date
  description = "The end date until which the certificate is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). If omitted, the API will decide a suitable expiry date, which is typically around 2 years from the start date"
}
output "end_date_relative" {
  value = azuread_application_certificate.appc.end_date_relative
  description = "A relative duration for which the certificate is valid until, for example `240h` (10 days) or `2400h30m`"
}
output "type" {
  value = azuread_application_certificate.appc.type
  description = "The type of key/certificate"
}
