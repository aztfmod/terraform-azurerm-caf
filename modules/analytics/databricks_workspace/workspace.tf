# naming convention
resource "azurecaf_name" "wp" {
  name          = var.settings.name
  resource_type = "azurerm_databricks_workspace"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

# Databricks workspace
resource "azurerm_databricks_workspace" "ws" {
  name                        = azurecaf_name.wp.result
  resource_group_name         = var.resource_group_name
  location                    = var.location
  sku                         = try(var.settings.sku, "standard")
  managed_resource_group_name = try(var.settings.managed_resource_group_name, null)
  tags                        = try(local.tags, null)

  dynamic "custom_parameters" {
    for_each = try(var.settings.custom_parameters, null) == null ? [] : [1]

    content {
      no_public_ip        = try(var.settings.custom_parameters.no_public_ip, false)
      public_subnet_name  = var.vnet == null ? data.terraform_remote_state.vnets[0].outputs[var.settings.custom_parameters.remote_tfstate.output_key][var.settings.custom_parameters.remote_tfstate.lz_key][var.settings.custom_parameters.remote_tfstate.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].name : var.vnet.subnets[var.settings.custom_parameters.public_subnet_key].name
      private_subnet_name = var.vnet == null ? data.terraform_remote_state.vnets[0].outputs[var.settings.custom_parameters.remote_tfstate.output_key][var.settings.custom_parameters.remote_tfstate.lz_key][var.settings.custom_parameters.remote_tfstate.vnet_key].subnets[var.settings.custom_parameters.private_subnet_key].name : var.vnet.subnets[var.settings.custom_parameters.private_subnet_key].name
      virtual_network_id  = var.vnet == null ? data.terraform_remote_state.vnets[0].outputs[var.settings.custom_parameters.remote_tfstate.output_key][var.settings.custom_parameters.remote_tfstate.lz_key][var.settings.custom_parameters.remote_tfstate.vnet_key].id : var.vnet.id
    }
  }
}


data "terraform_remote_state" "vnets" {
  count   = try(var.settings.custom_parameters.remote_tfstate, null) == null ? 0 : 1
  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[var.settings.custom_parameters.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[var.settings.custom_parameters.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[var.settings.custom_parameters.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[var.settings.custom_parameters.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[var.settings.custom_parameters.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[var.settings.custom_parameters.remote_tfstate.tfstate_key].tenant_id : null
  }
}