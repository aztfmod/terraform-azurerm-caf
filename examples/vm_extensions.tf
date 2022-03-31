#
# microsoft_enterprise_cloud_monitoring - Install the monitoring agent in the virtual machine
#

module "vm_extension_monitoring_agent" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.example]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring, null) != null
  }

  client_config      = module.example.client_config
  virtual_machine_id = module.example.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring
  extension_name     = "microsoft_enterprise_cloud_monitoring"
  settings = {
    diagnostics = module.example.diagnostics
  }
}

module "vm_extension_diagnostics" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.example]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_diagnostics, null) != null
  }

  client_config      = module.example.client_config
  virtual_machine_id = module.example.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_diagnostics
  extension_name     = "microsoft_azure_diagnostics"
  settings = {
    var_folder_path                  = var.var_folder_path
    diagnostics                      = module.example.diagnostics
    xml_diagnostics_file             = try(each.value.virtual_machine_extensions.microsoft_azure_diagnostics.xml_diagnostics_file, null)
    diagnostics_storage_account_keys = each.value.virtual_machine_extensions.microsoft_azure_diagnostics.diagnostics_storage_account_keys
  }
}

module "vm_extension_microsoft_azure_domainjoin" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.example] #refer landingzone.tf for the correct module name.

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_domainjoin, null) != null
  }

  client_config      = module.example.client_config                 #refer landingzone.tf for the correct module name.
  virtual_machine_id = module.example.virtual_machines[each.key].id #refer landingzone.tf for the correct module name.
  extension          = each.value.virtual_machine_extensions.microsoft_azure_domainjoin
  extension_name     = "microsoft_azure_domainJoin"
  keyvaults          = module.example.keyvaults
}

module "vm_extension_session_host_dscextension" {
  source     = "../modules/compute/virtual_machine_extensions"
  depends_on = [module.example, module.vm_extension_microsoft_azure_domainjoin] #refer landingzone.tf for the correct module name.

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.session_host_dscextension, null) != null
  }

  client_config      = module.example.client_config                 #refer landingzone.tf for the correct module name.
  virtual_machine_id = module.example.virtual_machines[each.key].id #refer landingzone.tf for the correct module name.
  extension          = each.value.virtual_machine_extensions.session_host_dscextension
  extension_name     = "session_host_dscextension"
  keyvaults          = module.example.keyvaults
  wvd_host_pools     = module.example.wvd_host_pools
}

module "vm_extension_custom_scriptextension" {
  source = "../modules/compute/virtual_machine_extensions"

  depends_on = [module.example, module.vm_extension_microsoft_azure_domainjoin]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.custom_script, null) != null
  }

  client_config           = module.example.client_config
  virtual_machine_id      = module.example.virtual_machines[each.key].id
  virtual_machine_os_type = module.example.virtual_machines[each.key].os_type
  extension               = each.value.virtual_machine_extensions.custom_script
  extension_name          = "custom_script"
  managed_identities = tomap(
    {
      (var.landingzone.key) = module.example.managed_identities
    }
  )
  storage_accounts = tomap(
    {
      (var.landingzone.key) = module.example.storage_accounts
    }
  )
}