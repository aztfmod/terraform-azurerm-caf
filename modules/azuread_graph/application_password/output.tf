output "application_object_id" {
  value       = azuread_application_password.appp.application_object_id
  description = "The object ID of the application for which this password should be created"
}
output "display_name" {
  value       = azuread_application_password.appp.display_name
  description = "A display name for the password"
}
output "start_date" {
  value       = azuread_application_password.appp.start_date
  description = "The start date from which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). If this isn't specified, the current date is used"
}
output "end_date" {
  value       = azuread_application_password.appp.end_date
  description = "The end date until which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`)"
}
output "end_date_relative" {
  value       = azuread_application_password.appp.end_date_relative
  description = "A relative duration for which the password is valid until, for example `240h` (10 days) or `2400h30m`. Changing this field forces a new resource to be created"
}
output "rotate_when_changed" {
  value       = azuread_application_password.appp.rotate_when_changed
  description = "Arbitrary map of values that, when changed, will trigger rotation of the password"
}
output "key_id" {
  value       = azuread_application_password.appp.key_id
  description = "A UUID used to uniquely identify this password credential"
}
