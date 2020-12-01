#
# microsoft_enterprise_cloud_monitoring - Install the monitoring agent in the virtual machine
#

module "vm_extension_monitoring_agent" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.caf]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring, null) != null
  }

  client_config      = module.caf.client_config
  virtual_machine_id = module.caf.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring
  extension_name     = "microsoft_enterprise_cloud_monitoring"
  settings = {
    diagnostics = module.caf.diagnostics
    log_analytics = map(
      module.caf.client_config.landingzone_key,
      module.caf.log_analytics
    )
  }
}

module "vm_extension_diagnostics" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.caf]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_diagnostics, null) != null
  }

  client_config      = module.caf.client_config
  virtual_machine_id = module.caf.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_diagnostics
  extension_name     = "microsoft_azure_diagnostics"
  settings = {
    storage_accounts = map(
      module.caf.client_config.landingzone_key,
      module.caf.storage_accounts
    )
    diagnostics                      = module.caf.diagnostics
    xml_diagnostics_file             = try(each.value.virtual_machine_extensions.microsoft_azure_diagnostics.xml_diagnostics_file, null)
    diagnostics_storage_account_keys = each.value.virtual_machine_extensions.microsoft_azure_diagnostics.diagnostics_storage_account_keys
  }
}
