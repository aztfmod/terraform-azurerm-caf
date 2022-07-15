output "application_object_id" {
  value       = azuread_application_federated_identity_credential.appfic.application_object_id
  description = "The object ID of the application for which this federated identity credential should be created"
}
output "audiences" {
  value       = azuread_application_federated_identity_credential.appfic.audiences
  description = "List of audiences that can appear in the external token. This specifies what should be accepted in the `aud` claim of incoming tokens."
}
output "display_name" {
  value       = azuread_application_federated_identity_credential.appfic.display_name
  description = "A unique display name for the federated identity credential"
}
output "issuer" {
  value       = azuread_application_federated_identity_credential.appfic.issuer
  description = "The URL of the external identity provider, which must match the issuer claim of the external token being exchanged. The combination of the values of issuer and subject must be unique on the app."
}
output "subject" {
  value       = azuread_application_federated_identity_credential.appfic.subject
  description = "The identifier of the external software workload within the external identity provider. The combination of issuer and subject must be unique on the app."
}
output "description" {
  value       = azuread_application_federated_identity_credential.appfic.description
  description = "A description for the federated identity credential"
}
output "credential_id" {
  value       = azuread_application_federated_identity_credential.appfic.credential_id
  description = "A UUID used to uniquely identify this federated identity credential"
}
