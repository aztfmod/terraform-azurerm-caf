module private_endpoint {
  source   = "../../networking/private_endpoint"
  for_each = var.private_endpoints

  resource_id         = azurerm_container_registry.acr.id
  name                = try(format("%s-to-%s-%s", each.value.name, each.value.vnet_key, each.value.subnet_key), format("%s-to-%s-%s-%s", each.value.name, each.value.remote_tfstate.lz_key, each.value.remote_tfstate.vnet_key, each.value.remote_tfstate.subnet_key))
  location            = var.resource_groups[each.value.resource_group_key].location
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  subnet_id           = try(var.vnets[each.value.vnet_key].subnets[each.value.subnet_key].id, data.terraform_remote_state.vnets[each.key].outputs[each.value.remote_tfstate.output_key][each.value.remote_tfstate.lz_key][each.value.remote_tfstate.vnet_key].subnets[each.value.remote_tfstate.subnet_key].id)
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = local.tags
}

data "terraform_remote_state" "vnets" {
  for_each = {
    for key, endpoint in var.private_endpoints : key => endpoint
    if try(endpoint.remote_tfstate, null) != null
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