#
# Key0 password_policy.rotation.mins,days,months,years is an ddd number
#

#
# Key1 password_policy.rotation.mins,days,months,years is an even number
#

locals {
  password_policy = try(var.settings.password_policy, var.password_policy)

  expiration_date = {
    key0 = timeadd(time_rotating.key0.id, format("%sh", local.password_policy.rotation_key0.days * 24))
    key1 = timeadd(time_rotating.key1.id, format("%sh", local.password_policy.rotation_key1.days * 24))
  }

  description = {
    key0 = format(
      "key0-%s-%s", 
      formatdate("YYMMDDhhmmss", time_rotating.key0.id),
      formatdate("YYMMDDhhmmss", local.expiration_date.key0)
    )
    key1 = format(
      "key1-%s-%s", 
      formatdate("YYMMDDhhmmss", time_rotating.key1.id),
      formatdate("YYMMDDhhmmss", local.expiration_date.key1)
    )
  }

  key0 = {
    mins                        = try(local.password_policy.rotation_key0.mins, null)
    days                        = try(local.password_policy.rotation_key0.days, null)
    months                      = try(local.password_policy.rotation_key0.months, null)
    years                       = try(local.password_policy.rotation_key0.years, null)
  }

  key1 = {
    mins                        = try(local.password_policy.rotation_key1.mins, null)
    days                        = try(local.password_policy.rotation_key1.days, null)
    months                      = try(local.password_policy.rotation_key1.months, null)
    years                       = try(local.password_policy.rotation_key1.years, null)
  }
}

resource "time_rotating" "key0" {
  rotation_minutes = local.key0.mins
  rotation_days    = local.key0.days
  rotation_months  = local.key0.months
  rotation_years   = local.key0.years
}

resource "random_password" "key0" {
  keepers = {
    frequency = time_rotating.key0.id
  }
  length  = local.password_policy.length
  special = local.password_policy.special
  upper   = local.password_policy.upper
  number  = local.password_policy.number
}


resource "time_rotating" "key1" {
  rotation_minutes = local.key1.mins
  rotation_days    = local.key1.days
  rotation_months  = local.key1.months
  rotation_years   = local.key1.years
}

resource "random_password" "key1" {
  keepers = {
    frequency = time_rotating.key1.id
  }
  length  = local.password_policy.length
  special = local.password_policy.special
  upper   = local.password_policy.upper
  number  = local.password_policy.number
}