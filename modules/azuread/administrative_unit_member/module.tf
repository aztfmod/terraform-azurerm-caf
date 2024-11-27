resource "azuread_administrative_unit_member" "admum" {
  administrative_unit_object_id = can(var.settings.administrative_unit_object.id) ? var.settings.administrative_unit_object.id : var.remote_objects.azuread_administrative_units[try(var.settings.administrative_unit_object.lz_key, var.client_config.landingzone_key)][var.settings.administrative_unit_object.key].object_id
  member_object_id              = can(var.settings.member_object.id) ? var.settings.member_object.id : var.remote_objects[var.settings.member_object.resource_type][try(var.settings.member_object.lz_key, var.client_config.landingzone_key)][var.settings.member_object.key].object_id
}
