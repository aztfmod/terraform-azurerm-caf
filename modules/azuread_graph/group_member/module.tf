
resource "azuread_group_member" "grom" {
  group_object_id  = can(var.settings.group_object.id) ? var.settings.group_object.id : var.remote_objects.azuread_groups[try(var.settings.group_object.lz_key, var.client_config.landingzone_key)][var.settings.group_object.key].object_id
  member_object_id = can(var.settings.member_object.id) ? var.settings.member_object.id : var.remote_objects.aad[var.settings.member_object.obj_type][try(var.settings.member_object.lz_key, var.client_config.landingzone_key)][var.settings.member_object.key].object_id
}
