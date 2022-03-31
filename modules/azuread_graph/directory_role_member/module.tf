 
resource "azuread_directory_role_member" "dirrm" {
  role_object_id =  can(var.settings.role_object.key) == false ? try(var.settings.role_object.id, null) : var.remote_objects.aad[var.settings.role_object.obj_type][try(var.settings.role_object.lz_key, var.client_config.landingzone_key)][var.settings.role_object.key].object_id
  member_object_id =  can(var.settings.member_object.key) == false ? try(var.settings.member_object.id, null) : var.remote_objects.aad[var.settings.member_object.obj_type][try(var.settings.member_object.lz_key, var.client_config.landingzone_key)][var.settings.member_object.key].object_id
}
