locals {
  backend_pools_app_services = {
    for key, value in try(var.settings.backend_pools, {}) : key => flatten(
      [
        for app_service_key, app_service in try(value.app_services, {}) : [
          try(var.app_services[app_service.lz_key][app_service.key].default_site_hostname, var.app_services[var.client_config.landingzone_key][app_service.key].default_site_hostname)
        ]
      ]
    ) if lookup(value, "app_services", false) != false
  }

  # backend_pools_fqdn = {
  #   for key, value in var.settings.backend_pools : key => flatten(
  #     [
  #       try(value.fqdns, [])
  #     ]
  #   ) if lookup(value, "fqdns", false) != false
  # }

  # backend_pools_vmss = {
  #   for key, value in var.settings : key = > flatten(
  #     [
  #       try(value.backend_pool.vmss,)
  #     ]
  #   )
  # }

  backend_pools = {
    for key, value in try(var.settings.backend_pools, {}) : key => {
      address_pools = join(" ", try(flatten(
        [
          try(local.backend_pools_app_services[key], []),
          try(value.fqdns, []),
          try(value.ip_addresses, [])
        ]
      ), null))
    }
  }
}
