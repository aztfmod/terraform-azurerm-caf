resource "azuread_app_role_assignment" "appra" {
  app_role_id         = can(var.settings.app_role.key) == false ? var.settings.app_role.id : var.remote_objects.aad[var.settings.app_role.obj_type][try(var.settings.app_role.lz_key, var.client_config.landingzone_key)][var.settings.app_role.key].app_role_ids[var.settings.app_role.role]
  principal_object_id = can(var.settings.principal_object.id) ? var.settings.principal_object.id : var.remote_objects.aad[var.settings.principal_object.obj_type][try(var.settings.principal_object.lz_key, var.client_config.landingzone_key)][var.settings.principal_object.key].object_id
  resource_object_id  = can(var.settings.resource_object.id) ? var.settings.resource_object.id : var.remote_objects.aad[var.settings.resource_object.obj_type][try(var.settings.resource_object.lz_key, var.client_config.landingzone_key)][var.settings.resource_object.key].object_id
}
