module "vm_extension_monitoring_agent" {
  source = "../../../../../modules/compute/virtual_machine_extensions"
  depends_on = [module.caf]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprisecloud_monitoring, null) != null
  }

  client_config      = module.caf.client_config
  virtual_machine_id = module.caf.virtual_machines[each.key].id
  extensions         = each.value.virtual_machine_extensions
  settings = {
    microsoft_enterprisecloud_monitoring = {
      log_analytics = map(
        module.caf.client_config.landingzone_key,
        module.caf.log_analytics
      )
    }
  }
}

