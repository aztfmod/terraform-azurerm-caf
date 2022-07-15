
resource "azuread_service_principal_delegated_permission_grant" "serpdpg" {
  claim_values                         = var.settings.claim_values
  resource_service_principal_object_id = can(var.settings.resource_service_principal_object.key) ? var.settings.resource_service_principal_object.id : var.remote_objects.aad[var.settings.resource_service_principal_object.obj_type][try(var.settings.resource_service_principal_object.lz_key, var.client_config.landingzone_key)][var.settings.resource_service_principal_object.key].object_id
  service_principal_object_id          = can(var.settings.service_principal_object.key) ? var.settings.service_principal_object.id : var.remote_objects.aad[var.settings.service_principal_object.obj_type][try(var.settings.service_principal_object.lz_key, var.client_config.landingzone_key)][var.settings.service_principal_object.key].object_id
  user_object_id                       = can(var.settings.user_object.key) == false ? try(var.settings.user_object.id, null) : var.remote_objects.aad[var.settings.user_object.obj_type][try(var.settings.user_object.lz_key, var.client_config.landingzone_key)][var.settings.user_object.key].object_id
}
