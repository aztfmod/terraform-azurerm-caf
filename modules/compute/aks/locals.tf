locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }

  tags = merge(var.base_tags, local.module_tag)

  # New identity format for user assigned MSIs
  identity_id_keys = can(var.settings.identity.identity_keys) ? flatten([
    for k, v in var.settings.identity.identity_keys : [
      try(
        v.identity_id,
        var.managed_identities[try(v.lz_key, var.client_config.landingzone_key)][v.identity_key].id
      )
    ]
  ]) : []

  # Legacy - kept for backward compatibility
  user_assigned_identity_id = can(var.settings.identity.user_assigned_identity_id) ? tolist([var.settings.identity.user_assigned_identity_id]) : tolist([
    try(var.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.identity.managed_identity_key].id, [])
  ])

  # Merge both lists
  identity_ids = toset(flatten(concat(local.identity_id_keys, local.user_assigned_identity_id)))

  enable_preview = {
    HTTPProxyConfigPreview                = length(try(var.settings.http_proxy_config, [])) > 0
    EnablePrivateClusterPublicFQDN        = try(var.settings.private_cluster_public_fqdn_enabled, false)
    EnableWorkloadIdentityPreview         = try(var.settings.workload_identity_enabled, false)
    EnableAPIServerVnetIntegrationPreview = try(var.settings.api_server_access_profile.vnet_integration_enabled, false)
    CustomCATrustPreview                  = try(var.settings.default_node_pool.custom_ca_trust_enabled, false)
    PodSubnetPreview                      = try(var.settings.default_node_pool.pod_subnet_key, false)
    NodePublicIPTagsPreview               = length(try(var.settings.default_node_pool.node_network_profile, [])) > 0
    CiliumDataplanePreview                = upper(try(var.settings.network_profile.ebpf_data_plane, "")) == "CILIUM"
    AzureOverlayPreview                   = upper(try(var.settings.network_profile.network_plugin_mode, "")) == "OVERLAY"
    EnableAzureDiskCSIDriverV2            = length(try(var.settings.storage_profile, [])) > 0
    EnableImageCleanerPreview             = try(var.settings.image_cleaner_enabled, false)
    "AKS-PrometheusAddonPreview"          = false
    "AKS-AzureDefender"                   = length(try(var.settings.microsoft_defender, [])) > 0
    "AKS-EnableDualStack"                 = contains(try(var.settings.network_profile.ip_versions, []), "IPv6")
    "AKS-KedaPreview"                     = try(var.settings.workload_autoscaler_profile.keda_enabled, false)
  }
}
