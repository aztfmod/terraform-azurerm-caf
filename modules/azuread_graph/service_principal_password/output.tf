output "service_principal_id" {
  value = azuread_service_principal_password.serpp.service_principal_id
  description = "The object ID of the service principal for which this password should be created"
}
output "display_name" {
  value = azuread_service_principal_password.serpp.display_name
  description = "A display name for the password"
}
output "start_date" {
  value = azuread_service_principal_password.serpp.start_date
  description = "The start date from which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). If this isn't specified, the current date is used"
}
output "end_date" {
  value = azuread_service_principal_password.serpp.end_date
  description = "The end date until which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`)"
}
output "end_date_relative" {
  value = azuread_service_principal_password.serpp.end_date_relative
  description = "A relative duration for which the password is valid until, for example `240h` (10 days) or `2400h30m`. Changing this field forces a new resource to be created"
}
output "rotate_when_changed" {
  value = azuread_service_principal_password.serpp.rotate_when_changed
  description = "Arbitrary map of values that, when changed, will trigger rotation of the password"
}
output "key_id" {
  value = azuread_service_principal_password.serpp.key_id
  description = "A UUID used to uniquely identify this password credential"
}
