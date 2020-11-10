locals {
  backend_pools_app_services = {
    for agw_config_key, value in var.application_gateway_applications : agw_config_key => flatten(
      [
        for app_service_key, app_service in try(value.backend_pool.app_services, {}) : [
          try(var.app_services[app_service.lz_key][app_service.key].default_site_hostname, var.app_services[var.client_config.landingzone_key][app_service.key].default_site_hostname)
        ]
      ]
    )
  }

  backend_pools_fqdn = {
    for key, value in var.application_gateway_applications : key => flatten(
      [
        try(value.backend_pool.fqdns, [])
      ]
    )
  }

  backend_pools = {
    for key, value in var.application_gateway_applications : key => {
      name = try(value.backend_pool.name, value.name)
      fqdns = flatten(
        [
          local.backend_pools_app_services[key],
          local.backend_pools_fqdn[key]
        ]
      )
      ip_addresses = try(value.backend_pool.ip_addresses, null)
    }
  }
}
