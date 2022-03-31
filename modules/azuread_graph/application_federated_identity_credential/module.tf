 
resource "azuread_application_federated_identity_credential" "appfic" {
  application_object_id =  can(var.settings.application_object.key)  ? var.settings.application_object.id : var.remote_objects.aad[var.settings.application_object.obj_type][try(var.settings.application_object.lz_key, var.client_config.landingzone_key)][var.settings.application_object.key].object_id
  audiences = var.settings.audiences
  display_name = var.settings.display_name
  issuer = var.settings.issuer
  subject = var.settings.subject
  description = try(var.settings.description, null)
}
