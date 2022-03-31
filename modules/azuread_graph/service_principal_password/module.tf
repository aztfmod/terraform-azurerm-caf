
resource "azuread_service_principal_password" "serpp" {
  service_principal_id = can(var.settings.service_principal.id) ? var.settings.service_principal.id : var.remote_objects.azuread_service_principals[try(var.settings.service_principal.lz_key, var.client_config.landingzone_key)][var.settings.service_principal.key].object_id
  display_name         = try(var.settings.display_name, null)
  start_date           = try(var.settings.start_date, null)
  end_date             = try(var.settings.end_date, null)
  end_date_relative    = try(var.settings.end_date_relative, null)
  rotate_when_changed  = try(var.settings.rotate_when_changed, null)
}
