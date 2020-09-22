
module "app_services" {
  source = "./modules/webapps/appservice"

  for_each = local.webapp.app_services

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_plan_id = lookup(each.value, "app_service_plan_key", null) == null ? null : try(module.app_service_plans[each.value.app_service_plan_key].id, data.terraform_remote_state.app_service_remote_plans[each.key].outputs[each.value.remote_tfstate.output_key][each.value.app_service_plan_key].id)
  settings            = each.value.settings
  identity            = try(each.value.identity, {})
  connection_strings  = try(each.value.connection_strings, {})
  app_settings        = try(each.value.app_settings, null)
  slots               = try(each.value.slots, {})
  global_settings     = local.global_settings
  tags                = try(each.value.tags, null)
}

#
# Get remote appl service plan to deploy the app service
#
data "terraform_remote_state" "app_service_remote_plans" {
  for_each = {
    for key, value in local.webapp.app_services : key => value
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


output "app_services" {
  value = module.app_services
}
