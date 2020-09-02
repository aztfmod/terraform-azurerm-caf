module aks_clusters {
  source   = "./modules/compute/aks"
  for_each = local.compute.aks_clusters

  global_settings = local.global_settings
  diagnostics     = local.diagnostics
  settings        = each.value
  subnets         = try(each.value.networking.remote_tfstate, null) == null ? module.networking[each.value.networking.vnet_key].subnets : data.terraform_remote_state.vnets[each.key].outputs[each.value.networking.remote_tfstate.output_key][each.value.networking.remote_tfstate.lz_key][each.value.networking.remote_tfstate.vnet_key].subnets
  resource_group  = azurerm_resource_group.rg[each.value.resource_group_key]
  admin_group_ids = try(each.value.admin_groups.azuread_group_keys, null) == null ? each.value.admin_groups.ids : [for group_key in each.value.admin_groups.azuread_group_keys : module.azuread_groups[group_key].id]
}

data "terraform_remote_state" "vnets" {
  for_each = {
    for key, aks in local.compute.aks_clusters : key => aks
    if try(aks.networking.remote_tfstate, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.networking.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.networking.remote_tfstate.tfstate_key].tenant_id : null
  }
}