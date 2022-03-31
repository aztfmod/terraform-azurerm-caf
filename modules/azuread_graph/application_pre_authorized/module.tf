 
resource "azuread_application_pre_authorized" "apppa" {
  application_object_id =  can(var.settings.application_object.key)  ? var.settings.application_object.id : var.remote_objects.aad[var.settings.application_object.obj_type][try(var.settings.application_object.lz_key, var.client_config.landingzone_key)][var.settings.application_object.key].object_id
  authorized_app_id =  can(var.settings.authorized_app.key)  ? var.settings.authorized_app.id : var.remote_objects.aad[var.settings.authorized_app.obj_type][try(var.settings.authorized_app.lz_key, var.client_config.landingzone_key)][var.settings.authorized_app.key].object_id
  permission_ids = var.settings.permission_ids
}
