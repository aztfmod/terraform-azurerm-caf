
module "app_service_environments" {
  source = "./modules/webapps/ase"

  for_each = local.webapp.app_service_environments

  settings                  = each.value
  resource_group_name       = module.resource_groups[each.value.resource_group_key].name
  location                  = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  tags                      = try(each.value.tags, null)
  name                      = each.value.name
  kind                      = try(each.value.kind, "ASEV2")
  zone                      = try(each.value.zone, null)
  subnet_id                 = lookup(each.value, "remote_tfstate", null) == null ? module.networking[each.value.vnet_key].subnets[each.value.subnet_key].id : data.terraform_remote_state.ase_vnets[each.key].outputs[each.value.remote_tfstate.output_key][each.value.remote_tfstate.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id
  subnet_name               = lookup(each.value, "remote_tfstate", null) == null ? module.networking[each.value.vnet_key].subnets[each.value.subnet_key].name : data.terraform_remote_state.ase_vnets[each.key].outputs[each.value.remote_tfstate.output_key][each.value.remote_tfstate.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].name
  internalLoadBalancingMode = each.value.internalLoadBalancingMode
  front_end_size            = try(each.value.front_end_size, "Standard_D1_V2")
  diagnostic_profiles       = try(each.value.diagnostic_profiles, null)
  diagnostics               = local.diagnostics
  global_settings           = local.global_settings
  tfstates                  = var.tfstates
  use_msi                   = var.use_msi
  private_dns               = lookup(each.value, "private_dns_records", null) == null ? {} : module.private_dns
}

#
# Get remote vnet to deploy the ase
#
data "terraform_remote_state" "ase_vnets" {
  for_each = {
    for key, value in local.webapp.app_service_environments : key => value
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


output "app_service_environments" {
  value     = module.app_service_environments
  sensitive = true
}