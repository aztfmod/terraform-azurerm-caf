
output mssql_databases {
  value     = module.mssql_databases
  sensitive = true
}

module "mssql_databases" {
  source   = "./modules/databases/mssql_database"
  for_each = local.database.mssql_databases

  global_settings  = local.global_settings
  settings         = each.value
  server_id        = try(each.value.remote_tfstate, null) == null ? module.mssql_servers[each.value.mssql_server_key].id : data.terraform_remote_state.mssql_remote_server[each.key].outputs[each.value.remote_tfstate.output_key][each.value.mssql_server_key].id
  elastic_pool_id  = try(module.mssql_elastic_pools[each.value.elastic_pool_key].id, null)
  storage_accounts = module.storage_accounts
  base_tags        = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}

#
# Get remote mssql server to deploy the database
#
data "terraform_remote_state" "mssql_remote_server" {
  for_each = {
    for key, value in local.database.mssql_databases : key => value
    if try(value.remote_tfstate, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.remote_tfstate.tfstate_key].tenant_id : null
  }
}