
resource "azuread_service_principal_password" "pwd" {
  service_principal_id = var.service_principal_id
  end_date             = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))

  rotate_when_changed = {
    rotation = time_rotating.pwd.id
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "time_rotating" "pwd" {
  rotation_minutes = try(local.password_policy.rotation.mins, null)
  rotation_days    = try(local.password_policy.rotation.days, null)
  rotation_months  = try(local.password_policy.rotation.months, null)
  rotation_years   = try(local.password_policy.rotation.years, null)
}
