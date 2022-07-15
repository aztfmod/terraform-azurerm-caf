
resource "azuread_application_federated_identity_credential" "appfic" {
  application_object_id = can(var.settings.application_object.object_id) ? var.settings.application_object.object_id : var.remote_objects[var.settings.application_object.obj_type][try(var.settings.application_object.lz_key, var.client_config.landingzone_key)][var.settings.application_object.key].object_id
  audiences             = var.settings.audiences
  display_name          = var.settings.display_name
  issuer                = try(var.settings.issuer, format("https://login.microsoftonline.com/%s/v2.0", var.client_config.tenant_id))
  subject               = can(var.settings.subject) ? var.settings.subject : var.remote_objects[var.settings.subject_object.obj_type][try(var.settings.subject_object.lz_key, var.client_config.landingzone_key)][var.settings.subject_object.key].object_id
  description           = try(var.settings.description, null)
}
