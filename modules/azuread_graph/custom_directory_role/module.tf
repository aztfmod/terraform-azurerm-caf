 
resource "azuread_custom_directory_role" "cusdr" {
  display_name = var.settings.display_name
  enabled = var.settings.enabled
  dynamic "permissions" {
    for_each = try(var.settings.permissions, null) != null ? [var.settings.permissions] : []
    content { 
      allowed_resource_actions = permissions.value.allowed_resource_actions
    }
  }
  version = var.settings.version
  description = try(var.settings.description, null)
  template_id =  can(var.settings.template.key) == false ? try(var.settings.template.id, null) : var.remote_objects.aad[var.settings.template.obj_type][try(var.settings.template.lz_key, var.client_config.landingzone_key)][var.settings.template.key].object_id
}
