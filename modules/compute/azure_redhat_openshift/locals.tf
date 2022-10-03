locals {

  service_principal = {
    clientId     = can(var.settings.service_principal.client_id) ? var.settings.service_principal.client_id : data.azurerm_key_vault_secret.id[0].value
    clientSecret = can(var.settings.service_principal.client_secret) ? var.settings.service_principal.client_secret : data.azurerm_key_vault_secret.password[0].value
  }

  master_profile = {
    vmSize              = var.settings.master_profile.vm_size
    diskEncryptionSetId = can(var.settings.master_profile.disk_encryption_set_id) || can(var.settings.master_profile.disk_encryption_set_key) == false ? try(var.settings.master_profile.disk_encryption_set_id, null) : var.combined_resources.disk_encryption_sets[try(var.settings.master_profile.disk_encryption_sets.lz_key, var.client_config.landingzone_key)][var.settings.master_profile.disk_encryption_set_key].id
    encryptionAtHost    = try(var.settings.master_profile.encryption_at_host, null)
    subnetId            = can(var.settings.master_profile.subnet.id) ? var.settings.master_profile.subnet.id : var.combined_resources.vnets[try(var.settings.master_profile.subnet.lz_key, var.client_config.landingzone_key)][var.settings.master_profile.subnet.vnet.key].subnets[var.settings.master_profile.subnet.key].id
  }

  worker_profiles = [
    for worker_profile in var.settings.worker_profiles : {
      count               = tonumber(worker_profile.node_count)
      diskSizeGB          = tonumber(worker_profile.disk_size_gb)
      diskEncryptionSetId = can(worker_profile.disk_encryption_set_id) || can(worker_profile.disk_encryption_set_key) == false ? try(worker_profile.disk_encryption_set_id, null) : var.combined_resources.disk_encryption_sets[try(worker_profile.disk_encryption_sets.lz_key, var.client_config.landingzone_key)][worker_profile.disk_encryption_set_key].id
      encryptionAtHost    = try(worker_profile.encryption_at_host, null)
      name                = worker_profile.name
      vmSize              = worker_profile.vm_size
      subnetId            = can(worker_profile.subnet.id) ? worker_profile.subnet.id : var.combined_resources.vnets[try(worker_profile.subnet.lz_key, var.client_config.landingzone_key)][worker_profile.subnet.vnet.key].subnets[worker_profile.subnet.key].id
    }
  ]

  cluster_profile = {
    domain          = azurecaf_name.aro_cluster.result
    resourceGroupId = can(var.settings.cluster_profile.resource_group.id) ? var.settings.cluster_profile.resource_group.id : format("/subscriptions/%s/resourceGroups/%s", var.client_config.subscription_id, azurecaf_name.aro_res_rg[0].result)
    // If we could reuse a RG, would use that logic: var.combined_resources.resource_groups[try(var.settings.cluster_profile.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.cluster_profile.resource_group.key].id
    version              = var.settings.cluster_profile.version
    fipsValidatedModules = try(var.settings.cluster_profile.fips_validated_modules, null)
    pullSecret           = can(var.settings.cluster_profile.pull_secret.secret_id) ? data.azurerm_key_vault_secret.pull_secret[0].value : try(var.settings.cluster_profile.pull_secret.secret, null)
  }

  api_server_profile = {
    visibility = title(var.settings.api_server_profile.visibility)
  }

  ingress_profiles = [
    for ingress_profile in var.settings.ingress_profiles : {
      name       = ingress_profile.name
      visibility = title(ingress_profile.visibility)
    }
  ]

  network_profile = {
    podCidr     = var.settings.network_profile.pod_cidr
    serviceCidr = var.settings.network_profile.service_cidr
  }

}

## getting SP details from for AKV secrets in case provided
data "azurerm_key_vault_secret" "id" {
  count        = can(var.settings.service_principal.client_id) ? 0 : 1
  name         = format("%s-client-id", var.settings.service_principal.keyvault.secret_prefix)
  key_vault_id = var.combined_resources.keyvaults[try(var.settings.service_principal.keyvault.lz_key, var.client_config.landingzone_key)][var.settings.service_principal.keyvault.key].id
}

data "azurerm_key_vault_secret" "password" {
  count        = can(var.settings.service_principal.client_secret) ? 0 : 1
  name         = format("%s-client-secret", var.settings.service_principal.keyvault.secret_prefix)
  key_vault_id = var.combined_resources.keyvaults[try(var.settings.service_principal.keyvault.lz_key, var.client_config.landingzone_key)][var.settings.service_principal.keyvault.key].id
}

## direct pull secret with secret_id literals
data "azurerm_key_vault_secret" "pull_secret" {
  count        = can(var.settings.cluster_profile.pull_secret.secret_id) ? 1 : 0
  name         = var.settings.cluster_profile.pull_secret.secret_name
  key_vault_id = var.settings.cluster_profile.pull_secret.secret_id
}