
module "managed_identities" {
  source   = "./modules/security/managed_identity"
  for_each = var.managed_identities

  client_config       = local.client_config
  global_settings     = local.global_settings
  name                = each.value.name
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}

#Later can be added the same resources for other type of Federated Identity Credentials, GitHub and other.
data "azurecaf_name" "fidc" {
  for_each    = local.aks_federated_identity_credentials
  depends_on  = [module.managed_identities]

  name          = each.value.name
  resource_type = "azurerm_user_assigned_identity"
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

resource "azurerm_federated_identity_credential" "fidc_aks" {
  for_each    = local.aks_federated_identity_credentials
  depends_on  = [module.managed_identities]

  name                = data.azurecaf_name.fidc[each.key].result
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group)].name
  audience            = each.value.audience
  issuer              = each.value.issuer != null ? each.value.issuer : local.combined_objects_aks_clusters[try(each.value.aks_cluster.lz_key, local.client_config.landingzone_key)][each.value.aks_cluster.key].oidc_issuer_url
  parent_id           = module.managed_identities[each.value.managed_identity_key].id
  subject             = each.value.subject != null ? each.value.subject : try("system:serviceaccount:${each.value.kubernetes.namespace}:${each.value.kubernetes.service_account}", null)
}

locals {
  aks_federated_identity_credentials = {
    for mapping in flatten([
      for global_mode, global_values in var.managed_identities : [
        for identity_keys, federated_values in global_values : [
          for object_id_key, object_resources in federated_values : {
            name                  = object_id_key
            managed_identity_key  = global_mode
            resource_group        = try(global_values.resource_group_key, global_values.resource_group)
            aks_cluster           = try(object_resources.aks_cluster, null)
            issuer                = try(object_resources.issuer, null)
            kubernetes            = try(object_resources.kubernetes, null)
            audience              = try(object_resources.audience, ["api://AzureADTokenExchange"])
            subject               = try(object_resources.subject, null)
          } if try(object_resources.aks_cluster, null) != null || can(regex("cluster.azure.com", object_resources.issuer))
        ] if identity_keys == "federated_credential"
      ]
    ]) : format("%s_%s_%s", mapping.name, mapping.managed_identity_key, try(mapping.resource_group.key, mapping.resource_group)) => mapping
  } 
}

output "managed_identities" {
  value = module.managed_identities

}

# "service-one_federated_identity_nonprod-cluster_identity" = {
#   "name"          = "service-one"
#   "aks_cluster"   = {
#     "key"     = "cluster"
#     "lz_key"  = "platform"
#   }
#   "issuer"      = null
#   "kubernetes"  = {
#     "service_account" = "backend"
#     "namespace"       = "api"
#   }
#   "audience"              = "api://AzureADTokenExchange"
#   "subject"               = null
#   "managed_identity_key"  = "nonprod-cluster"
#   "resource_group"        = "identity" 
# }
# "database_federated_identity_poc_dev" = {
#   "name"        = "database"
#   "aks_cluster" = null
#   "issuer"      = "https://westeurope.oic.dev-cluster.azure.com/652ea6e0-593d-4ec5-1f63-171b4d354180/eeaa8533-ad54-4106-9b8b-c389480b31e7/"
#   "kubernetes"  = {
#     "service_account"   = null
#     "namespace"         = null
#   }
#   "audience"              = "api://AzureADTokenExchange"
#   "subject"               = "system:serviceaccount:kube-public:mssql"
#   "managed_identity_key"  = "poc"
#   "resource_group"        = {
#     "lz_key"  = "mi"
#     "key"     = "dev" 
#   }
# }
