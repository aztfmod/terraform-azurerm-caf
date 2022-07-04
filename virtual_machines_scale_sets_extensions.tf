module "vmss_extension_custom_scriptextension" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.custom_script, null) != null
  }

  client_config                     = local.client_config
  virtual_machine_scale_set_id      = module.virtual_machine_scale_sets[each.key].id
  extension                         = each.value.virtual_machine_scale_set_extensions.custom_script
  extension_name                    = "custom_script"
  managed_identities                = local.combined_objects_managed_identities
  storage_accounts                  = local.combined_objects_storage_accounts
  virtual_machine_scale_set_os_type = module.virtual_machine_scale_sets[each.key].os_type
}

module "vmss_extension_microsoft_azure_domainjoin" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin, null) != null
  }

  client_config                = local.client_config
  virtual_machine_scale_set_id = module.virtual_machine_scale_sets[each.key].id
  extension                    = each.value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin
  extension_name               = "microsoft_azure_domainJoin"
  keyvaults                    = local.combined_objects_keyvaults
}


module "vmss_extension_microsoft_monitoring_agent" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.microsoft_monitoring_agent, null) != null
  }

  client_config                     = local.client_config
  virtual_machine_scale_set_id      = module.virtual_machine_scale_sets[each.key].id
  extension                         = each.value.virtual_machine_scale_set_extensions.microsoft_monitoring_agent
  extension_name                    = "microsoft_monitoring_agent"
  virtual_machine_scale_set_os_type = module.virtual_machine_scale_sets[each.key].os_type
  log_analytics_workspaces          = local.combined_objects_log_analytics
}

module "vmss_extension_dependency_agent" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.dependency_agent, null) != null
  }

  client_config                     = local.client_config
  virtual_machine_scale_set_id      = module.virtual_machine_scale_sets[each.key].id
  extension                         = each.value.virtual_machine_scale_set_extensions.dependency_agent
  extension_name                    = "dependency_agent"
  virtual_machine_scale_set_os_type = module.virtual_machine_scale_sets[each.key].os_type
}

module "vmss_extension_application_health_extension" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.microsoft_azure_health_extension, null) != null
  }

  client_config                     = local.client_config
  virtual_machine_scale_set_id      = module.virtual_machine_scale_sets[each.key].id
  virtual_machine_scale_set_os_type = module.virtual_machine_scale_sets[each.key].os_type
  extension                         = each.value.virtual_machine_scale_set_extensions.microsoft_azure_health_extension
  extension_name                    = "microsoft_azure_health_extension"
}

module "vmss_extension_keyvault_extension" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.microsoft_azure_keyvault, null) != null
  }

  client_config                = local.client_config
  virtual_machine_scale_set_id = module.virtual_machine_scale_sets[each.key].id
  extension                    = each.value.virtual_machine_scale_set_extensions.microsoft_azure_keyvault
  extension_name               = "microsoft_azure_keyvault"
  managed_identities           = local.combined_objects_managed_identities
}


module "vmss_extension_custom_script_data_factory_self_hosted_runtime" {
  source = "./modules/compute/virtual_machine_scale_set_extensions"

  for_each = {
    for key, value in try(local.compute.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.data_factory_self_hosted_integration_runtime, null) != null
  }

  client_config                     = local.client_config
  virtual_machine_scale_set_id      = module.virtual_machine_scale_sets[each.key].id
  extension                         = each.value.virtual_machine_scale_set_extensions.data_factory_self_hosted_integration_runtime
  extension_name                    = "data_factory_self_hosted_integration_runtime"
  virtual_machine_scale_set_os_type = module.virtual_machine_scale_sets[each.key].os_type

  remote_objects = {
    data_factory_integration_runtime_self_hosted = local.combined_objects_data_factory_integration_runtime_self_hosted
    managed_identities                           = local.combined_objects_managed_identities
    storage_accounts                             = local.combined_objects_storage_accounts
  }
}
