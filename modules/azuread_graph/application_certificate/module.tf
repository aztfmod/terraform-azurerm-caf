
resource "azuread_application_certificate" "appc" {
  application_object_id = can(var.settings.application_object.key) ? var.settings.application_object.id : var.remote_objects.aad[var.settings.application_object.obj_type][try(var.settings.application_object.lz_key, var.client_config.landingzone_key)][var.settings.application_object.key].object_id
  encoding              = try(var.settings.encoding, null)
  key_id                = can(var.settings.key.key) == false ? try(var.settings.key.id, null) : var.remote_objects.aad[var.settings.key.obj_type][try(var.settings.key.lz_key, var.client_config.landingzone_key)][var.settings.key.key].object_id
  start_date            = try(var.settings.start_date, null)
  end_date              = try(var.settings.end_date, null)
  end_date_relative     = try(var.settings.end_date_relative, null)
  type                  = try(var.settings.type, null)
  value                 = var.settings.value
}
