locals {
  ip_restrictions     = try(var.settings.site_config.ip_restriction, [])
  scm_ip_restrictions = try(var.settings.site_config.scm_ip_restriction, [])
  site_config         = try(var.settings.site_config, {})
  auth_settings_v2    = try(var.settings.auth_settings_v2, {})
  auth_settings       = try(var.settings.auth_settings, {})
}
