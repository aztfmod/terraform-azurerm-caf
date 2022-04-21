
locals {

  number_of_ips = pow(2, 32 - var.prefix_length)

  pip = {
    location                = try(var.pip_settings.location, var.location)
    resource_group_name     = try(var.pip_settings.resource_group_name, var.resource_group_name)
    idle_timeout_in_minutes = try(var.pip_settings.idle_timeout_in_minutes, 4)
    domain_name_label       = try(var.pip_settings.domain_name_label, null)
    reverse_fqdn            = try(var.pip_settings.reverse_fqdn, null)
    tags                    = try(var.pip_settings.tags, var.tags)
    ip_tags                 = try(var.pip_settings.ip_tags, null)
    diagnostic_profiles     = try(var.pip_settings.diagnostic_profiles, null)
  }

}
