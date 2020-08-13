# output aad_apps {
#   sensitive = true
#   value = azuread_application.aad_apps
# }

output aad_apps {
  description = "Output the full Azure AD application registration object."
  value       = local.aad_apps_output
}