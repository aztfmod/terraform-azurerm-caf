
resource "azuread_service_principal_password" "pwd" {
  service_principal_id = can(var.settings.service_principal.id) ? var.settings.service_principal.id : var.remote_objects.azuread_service_principals[try(var.settings.service_principal.lz_key, var.client_config.landingzone_key)][var.settings.service_principal.key].object_id
  display_name         = try(var.settings.display_name, null)
  start_date           = try(var.settings.start_date, null)
  end_date             = try(var.settings.end_date, null)
  end_date_relative    = try(var.settings.end_date_relative, null)
  rotate_when_changed = {
    rotation = time_rotating.pwd.id
  }

  lifecycle {
    create_before_destroy = false
  }
}

locals {
  password_policy = try(var.settings.password_policy, var.password_policy)
}

resource "time_rotating" "pwd" {
  rotation_minutes = try(local.password_policy.rotation.mins, null)
  rotation_days    = try(local.password_policy.rotation.days, null)
  rotation_months  = try(local.password_policy.rotation.months, null)
  rotation_years   = try(local.password_policy.rotation.years, null)
}
