module "synapse_firewall_rule" {
  source          = "./modules/synapse/synapse_firewall_rule"
  for_each        = local.synapse.synapse_firewall_rule
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_firewall_rule" {
  value = module.synapse_firewall_rule
}

module "synapse_integration_runtime_azure" {
  source          = "./modules/synapse/synapse_integration_runtime_azure"
  for_each        = local.synapse.synapse_integration_runtime_azure
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_integration_runtime_azure" {
  value = module.synapse_integration_runtime_azure
}

module "synapse_integration_runtime_self_hosted" {
  source          = "./modules/synapse/synapse_integration_runtime_self_hosted"
  for_each        = local.synapse.synapse_integration_runtime_self_hosted
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_integration_runtime_self_hosted" {
  value = module.synapse_integration_runtime_self_hosted
}

module "synapse_linked_service" {
  source          = "./modules/synapse/synapse_linked_service"
  for_each        = local.synapse.synapse_linked_service
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_linked_service" {
  value = module.synapse_linked_service
}

module "synapse_managed_private_endpoint" {
  source          = "./modules/synapse/synapse_managed_private_endpoint"
  for_each        = local.synapse.synapse_managed_private_endpoint
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_managed_private_endpoint" {
  value = module.synapse_managed_private_endpoint
}

module "synapse_private_link_hub" {
  source          = "./modules/synapse/synapse_private_link_hub"
  for_each        = local.synapse.synapse_private_link_hub
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  remote_objects = {
    resource_group = local.combined_objects_resource_groups
  }
}
output "synapse_private_link_hub" {
  value = module.synapse_private_link_hub
}

module "synapse_role_assignment" {
  source          = "./modules/synapse/synapse_role_assignment"
  for_each        = local.synapse.synapse_role_assignment
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace  = local.combined_objects_synapse_workspaces
    synapse_spark_pool = local.combined_objects_synapse_spark_pool
  }
}
output "synapse_role_assignment" {
  value = module.synapse_role_assignment
}

module "synapse_spark_pool" {
  source          = "./modules/synapse/synapse_spark_pool"
  for_each        = local.synapse.synapse_spark_pool
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_spark_pool" {
  value = module.synapse_spark_pool
}

module "synapse_sql_pool" {
  source          = "./modules/synapse/synapse_sql_pool"
  for_each        = local.synapse.synapse_sql_pool
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_sql_pool" {
  value = module.synapse_sql_pool
}

module "synapse_sql_pool_extended_auditing_policy" {
  source          = "./modules/synapse/synapse_sql_pool_extended_auditing_policy"
  for_each        = local.synapse.synapse_sql_pool_extended_auditing_policy
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
  }
}
output "synapse_sql_pool_extended_auditing_policy" {
  value = module.synapse_sql_pool_extended_auditing_policy
}

module "synapse_sql_pool_security_alert_policy" {
  source          = "./modules/synapse/synapse_sql_pool_security_alert_policy"
  for_each        = local.synapse.synapse_sql_pool_security_alert_policy
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
  }
}
output "synapse_sql_pool_security_alert_policy" {
  value = module.synapse_sql_pool_security_alert_policy
}

module "synapse_sql_pool_vulnerability_assessment" {
  source          = "./modules/synapse/synapse_sql_pool_vulnerability_assessment"
  for_each        = local.synapse.synapse_sql_pool_vulnerability_assessment
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
  }
}
output "synapse_sql_pool_vulnerability_assessment" {
  value = module.synapse_sql_pool_vulnerability_assessment
}

module "synapse_sql_pool_vulnerability_assessment_baseline" {
  source          = "./modules/synapse/synapse_sql_pool_vulnerability_assessment_baseline"
  for_each        = local.synapse.synapse_sql_pool_vulnerability_assessment_baseline
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
  }
}
output "synapse_sql_pool_vulnerability_assessment_baseline" {
  value = module.synapse_sql_pool_vulnerability_assessment_baseline
}

module "synapse_sql_pool_workload_classifier" {
  source          = "./modules/synapse/synapse_sql_pool_workload_classifier"
  for_each        = local.synapse.synapse_sql_pool_workload_classifier
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
  }
}
output "synapse_sql_pool_workload_classifier" {
  value = module.synapse_sql_pool_workload_classifier
}

module "synapse_sql_pool_workload_group" {
  source          = "./modules/synapse/synapse_sql_pool_workload_group"
  for_each        = local.synapse.synapse_sql_pool_workload_group
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
  }
}
output "synapse_sql_pool_workload_group" {
  value = module.synapse_sql_pool_workload_group
}

module "synapse_workspace" {
  source          = "./modules/synapse/synapse_workspace"
  for_each        = local.synapse.synapse_workspace
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  remote_objects = {
    resource_group                    = local.combined_objects_resource_groups
    storage_data_lake_gen2_filesystem = local.combined_objects_storage_data_lake_gen2_filesystem
  }
}
output "synapse_workspace" {
  value = module.synapse_workspace
}

module "synapse_workspace_aad_admin" {
  source          = "./modules/synapse/synapse_workspace_aad_admin"
  for_each        = local.synapse.synapse_workspace_aad_admin
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_workspace_aad_admin" {
  value = module.synapse_workspace_aad_admin
}

module "synapse_workspace_extended_auditing_policy" {
  source          = "./modules/synapse/synapse_workspace_extended_auditing_policy"
  for_each        = local.synapse.synapse_workspace_extended_auditing_policy
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_workspace_extended_auditing_policy" {
  value = module.synapse_workspace_extended_auditing_policy
}

module "synapse_workspace_keys" {
  source          = "./modules/synapse/synapse_workspace_keys"
  for_each        = local.synapse.synapse_workspace_keys
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_workspace_keys" {
  value = module.synapse_workspace_keys
}

module "synapse_workspace_security_alert_policy" {
  source          = "./modules/synapse/synapse_workspace_security_alert_policy"
  for_each        = local.synapse.synapse_workspace_security_alert_policy
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_workspace_security_alert_policy" {
  value = module.synapse_workspace_security_alert_policy
}

module "synapse_workspace_sql_aad_admin" {
  source          = "./modules/synapse/synapse_workspace_sql_aad_admin"
  for_each        = local.synapse.synapse_workspace_sql_aad_admin
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    synapse_workspace = local.combined_objects_synapse_workspaces
  }
}
output "synapse_workspace_sql_aad_admin" {
  value = module.synapse_workspace_sql_aad_admin
}

module "synapse_workspace_vulnerability_assessment" {
  source          = "./modules/synapse/synapse_workspace_vulnerability_assessment"
  for_each        = local.synapse.synapse_workspace_vulnerability_assessment
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
  }
}
output "synapse_workspace_vulnerability_assessment" {
  value = module.synapse_workspace_vulnerability_assessment
}