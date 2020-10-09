module compute_instance {
  source   = "./compute_instance"
  for_each = try(var.settings.compute_instances, {})

  global_settings                 = var.global_settings
  settings                        = each.value
  resource_group_name             = azurerm_machine_learning_workspace.ws.resource_group_name
  location                        = azurerm_machine_learning_workspace.ws.location
  machine_learning_workspace_name = azurerm_machine_learning_workspace.ws.name
  subnet_id                       = lookup(each.value, "remote_tfstate", null) == null ? var.networking[each.value.vnet_key].subnets[each.value.subnet_key].id : data.terraform_remote_state.vnets[each.key].outputs[each.value.remote_tfstate.output_key][each.value.remote_tfstate.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id
}

#
# Get remote vnet to deploy the ase
#
data "terraform_remote_state" "vnets" {
  for_each = {
    for key, value in try(var.settings.compute_instances, {}) : key => value
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
