
resource "azuread_service_principal_certificate" "serpc" {
  service_principal_id = can(var.settings.service_principal.id) ? var.settings.service_principal.id : var.remote_objects.azuread_service_principals[try(var.settings.service_principal.lz_key, var.client_config.landingzone_key)][var.settings.service_principal.key].object_id
  key_id               = try(var.settings.key.id, null)
  encoding             = try(var.settings.encoding, null)
  start_date           = try(var.settings.start_date, null)
  end_date             = try(var.settings.end_date, null)
  end_date_relative    = try(var.settings.end_date_relative, null)
  type                 = try(var.settings.type, null)
  value                = can(var.settings.value) ? file(var.settings.value) : null
}
