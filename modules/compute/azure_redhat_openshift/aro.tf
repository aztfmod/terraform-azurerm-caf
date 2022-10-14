# Implemnented as per https://docs.microsoft.com/en-us/azure/templates/microsoft.redhatopenshift/2022-04-01/openshiftclusters?pivots=deployment-language-terraform

resource "azurecaf_name" "aro_cluster" {
  name          = var.settings.name
  resource_type = "azurerm_redhat_openshift_cluster"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "aro_domain" {
  name          = var.settings.cluster_profile.domain
  resource_type = "azurerm_redhat_openshift_domain"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "aro_res_rg" {
  count         = can(var.settings.cluster_profile.resource_group.name) ? 1 : 0
  name          = var.settings.cluster_profile.resource_group.name
  resource_type = "azurerm_resource_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azapi_resource" "aro" {
  name      = azurecaf_name.aro_cluster.result
  location  = var.location
  parent_id = var.resource_group
  type      = "Microsoft.RedHatOpenShift/openShiftClusters@2022-04-01"
  tags      = local.tags

  body = jsonencode({
    properties = {
      masterProfile           = local.master_profile
      workerProfiles          = local.worker_profiles
      servicePrincipalProfile = local.service_principal
      clusterProfile          = local.cluster_profile
      ingressProfiles         = local.ingress_profiles
      apiserverProfile        = local.api_server_profile
      networkProfile          = local.network_profile
    }
  })

  timeouts {
    create = "60m"
  }
}

