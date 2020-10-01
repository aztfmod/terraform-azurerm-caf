#
# Get remote vnet to deploy the ase
#
data "terraform_remote_state" "vnets" {
  backend = "azurerm"
  config  = local.config_vnets
}

locals {
  config_vnets = try(var.settings.remote_tfstate, null) == null ? null : {
    storage_account_name = var.tfstates[var.settings.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[var.settings.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[var.settings.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[var.settings.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[var.settings.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[var.settings.remote_tfstate.tfstate_key].tenant_id : null
  }
}

#
# Get remote vnet to deploy the ase
#
data "terraform_remote_state" "public_ips" {
  backend = "azurerm"
  config  = local.config_public_ips
}

locals {
  config_public_ips = try(var.settings.remote_tfstate, null) == null ? null : {
    storage_account_name = var.tfstates[var.settings.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[var.settings.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[var.settings.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[var.settings.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[var.settings.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[var.settings.remote_tfstate.tfstate_key].tenant_id : null
  }
}