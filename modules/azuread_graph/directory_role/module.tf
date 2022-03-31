 
resource "azuread_directory_role" "dirr" {
  display_name = try(var.settings.display_name, null)
  template_id =  can(var.settings.template.key) == false ? try(var.settings.template.id, null) : var.remote_objects.aad[var.settings.template.obj_type][try(var.settings.template.lz_key, var.client_config.landingzone_key)][var.settings.template.key].object_id
}
