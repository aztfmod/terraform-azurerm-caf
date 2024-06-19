module "databricks_access_connectors" {
  source   = "./modules/analytics/databricks_access_connector"
  for_each = local.database.databricks_access_connectors

  client_config   = local.client_config
  global_settings = local.global_settings
  name            = each.value.name
  settings        = each.value
  resource_groups = local.combined_objects_resource_groups
  base_tags       = local.global_settings.inherit_tags
  remote_objects = {
    managed_identities = local.combined_objects_managed_identities
  }
}

output "databricks_access_connectors" {
  value = module.databricks_access_connectors
}
