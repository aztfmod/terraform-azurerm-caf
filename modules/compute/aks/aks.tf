## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
### Naming convention

resource "azurecaf_name" "aks" {
  name          = var.settings.name
  resource_type = "azurerm_kubernetes_cluster"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "default_node_pool" {
  name          = var.settings.default_node_pool.name
  resource_type = "aks_node_pool_linux"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# locals {
#   rg_node_name = lookup(var.settings, "node_resource_group", "${var.resource_group.name}-nodes")
# }

resource "azurecaf_name" "rg_node" {
  name          = var.settings.node_resource_group_name
  resource_type = "azurerm_resource_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

### AKS cluster resource

resource "azurerm_kubernetes_cluster" "aks" {
  name                              = azurecaf_name.aks.result
  location                          = local.location
  resource_group_name               = local.resource_group_name
  role_based_access_control_enabled = try(var.settings.role_based_access_control_enabled, null)

  default_node_pool {
    zones                         = try(var.settings.default_node_pool.zones, var.settings.default_node_pool.availability_zones, null)
    enable_auto_scaling           = try(var.settings.default_node_pool.enable_auto_scaling, false)
    enable_host_encryption        = try(var.settings.default_node_pool.enable_host_encryption, false)
    enable_node_public_ip         = try(var.settings.default_node_pool.enable_node_public_ip, false)
    fips_enabled                  = try(var.settings.default_node_pool.fips_enabled, null)
    kubelet_disk_type             = try(var.settings.default_node_pool.kubelet_disk_type, null)
    max_count                     = try(var.settings.default_node_pool.max_count, null)
    max_pods                      = try(var.settings.default_node_pool.max_pods, 30)
    min_count                     = try(var.settings.default_node_pool.min_count, null)
    name                          = var.settings.default_node_pool.name //azurecaf_name.default_node_pool.result
    node_count                    = try(var.settings.default_node_pool.node_count, 1)
    node_labels                   = try(var.settings.default_node_pool.node_labels, null)
    node_public_ip_prefix_id      = try(var.settings.default_node_pool.node_public_ip_prefix_id, null)
    only_critical_addons_enabled  = try(var.settings.default_node_pool.only_critical_addons_enabled, false)
    orchestrator_version          = try(var.settings.default_node_pool.orchestrator_version, try(var.settings.kubernetes_version, null))
    os_disk_size_gb               = try(var.settings.default_node_pool.os_disk_size_gb, null)
    os_disk_type                  = try(var.settings.default_node_pool.os_disk_type, null)
    os_sku                        = try(var.settings.default_node_pool.os_sku, null)
    tags                          = merge(try(var.settings.default_node_pool.tags, {}), local.tags)
    temporary_name_for_rotation   = try(var.settings.default_node_pool.temporary_name_for_rotation, null)
    type                          = try(var.settings.default_node_pool.type, "VirtualMachineScaleSets")
    ultra_ssd_enabled             = try(var.settings.default_node_pool.ultra_ssd_enabled, false)
    vm_size                       = var.settings.default_node_pool.vm_size
    capacity_reservation_group_id = try(var.settings.capacity_reservation_group_id, null)
    custom_ca_trust_enabled       = try(var.settings.custom_ca_trust_enabled, null)
    host_group_id                 = try(var.settings.host_group_id, null)

    pod_subnet_id  = can(var.settings.default_node_pool.pod_subnet_key) == false || can(var.settings.default_node_pool.pod_subnet.key) == false || can(var.settings.default_node_pool.pod_subnet_id) || can(var.settings.default_node_pool.pod_subnet.resource_id) ? try(var.settings.default_node_pool.pod_subnet_id, var.settings.default_node_pool.pod_subnet.resource_id, null) : var.vnets[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.vnet_key].subnets[try(var.settings.default_node_pool.pod_subnet_key, var.settings.default_node_pool.pod_subnet.key)].id
    vnet_subnet_id = can(var.settings.default_node_pool.vnet_subnet_id) || can(var.settings.default_node_pool.subnet.resource_id) ? try(var.settings.default_node_pool.vnet_subnet_id, var.settings.default_node_pool.subnet.resource_id) : var.vnets[try(var.settings.vnet.lz_key, var.settings.lz_key, var.client_config.landingzone_key)][try(var.settings.vnet.key, var.settings.vnet_key)].subnets[try(var.settings.default_node_pool.subnet_key, var.settings.default_node_pool.subnet.key)].id

    dynamic "upgrade_settings" {
      for_each = try(var.settings.default_node_pool.upgrade_settings, null) == null ? [] : [1]
      content {
        max_surge = upgrade_settings.value.max_surge
      }
    }

    dynamic "kubelet_config" {
      for_each = try(var.settings.default_node_pool.kubelet_config, null) == null ? [] : [1]
      content {
        allowed_unsafe_sysctls    = try(kubelet_config.value.allowed_unsafe_sysctls, null)
        container_log_max_line    = try(kubelet_config.value.container_log_max_line, null)
        container_log_max_size_mb = try(kubelet_config.value.container_log_max_size_mb, null)
        cpu_cfs_quota_enabled     = try(kubelet_config.value.cpu_cfs_quota_enabled, null)
        cpu_cfs_quota_period      = try(kubelet_config.value.cpu_cfs_quota_period, null)
        cpu_manager_policy        = try(kubelet_config.value.cpu_manager_policy, null)
        image_gc_high_threshold   = try(kubelet_config.value.image_gc_high_threshold, null)
        image_gc_low_threshold    = try(kubelet_config.value.image_gc_low_threshold, null)
        pod_max_pid               = try(kubelet_config.value.pod_max_pid, null)
        topology_manager_policy   = try(kubelet_config.value.topology_manager_policy, null)
      }
    }
    dynamic "linux_os_config" {
      for_each = try(var.settings.default_node_pool.linux_os_config, null) == null ? [] : [1]
      content {
        swap_file_size_mb = try(linux_os_config.value.allowed_unsafe_sysctls, null)
        dynamic "sysctl_config" {
          for_each = try(linux_os_config.value.sysctl_config, null) == null ? [] : [1]
          content {
            fs_aio_max_nr                      = try(sysctl_config.value.fs_aio_max_nr, null)
            fs_file_max                        = try(sysctl_config.value.fs_file_max, null)
            fs_inotify_max_user_watches        = try(sysctl_config.value.fs_inotify_max_user_watches, null)
            fs_nr_open                         = try(sysctl_config.value.fs_nr_open, null)
            kernel_threads_max                 = try(sysctl_config.value.kernel_threads_max, null)
            net_core_netdev_max_backlog        = try(sysctl_config.value.net_core_netdev_max_backlog, null)
            net_core_optmem_max                = try(sysctl_config.value.net_core_optmem_max, null)
            net_core_rmem_default              = try(sysctl_config.value.net_core_rmem_default, null)
            net_core_rmem_max                  = try(sysctl_config.value.net_core_rmem_max, null)
            net_core_somaxconn                 = try(sysctl_config.value.net_core_somaxconn, null)
            net_core_wmem_default              = try(sysctl_config.value.net_core_wmem_default, null)
            net_core_wmem_max                  = try(sysctl_config.value.net_core_wmem_max, null)
            net_ipv4_ip_local_port_range_max   = try(sysctl_config.value.net_ipv4_ip_local_port_range_max, null)
            net_ipv4_ip_local_port_range_min   = try(sysctl_config.value.net_ipv4_ip_local_port_range_min, null)
            net_ipv4_neigh_default_gc_thresh1  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh1, null)
            net_ipv4_neigh_default_gc_thresh2  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh2, null)
            net_ipv4_neigh_default_gc_thresh3  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh3, null)
            net_ipv4_tcp_fin_timeout           = try(sysctl_config.value.net_ipv4_tcp_fin_timeout, null)
            net_ipv4_tcp_keepalive_intvl       = try(sysctl_config.value.net_ipv4_tcp_keepalive_intvl, null)
            net_ipv4_tcp_keepalive_probes      = try(sysctl_config.value.net_ipv4_tcp_keepalive_probes, null)
            net_ipv4_tcp_keepalive_time        = try(sysctl_config.value.net_ipv4_tcp_keepalive_time, null)
            net_ipv4_tcp_max_syn_backlog       = try(sysctl_config.value.net_ipv4_tcp_max_syn_backlog, null)
            net_ipv4_tcp_max_tw_buckets        = try(sysctl_config.value.net_ipv4_tcp_max_tw_buckets, null)
            net_ipv4_tcp_tw_reuse              = try(sysctl_config.value.net_ipv4_tcp_tw_reuse, null)
            net_netfilter_nf_conntrack_buckets = try(sysctl_config.value.net_netfilter_nf_conntrack_buckets, null)
            net_netfilter_nf_conntrack_max     = try(sysctl_config.value.net_netfilter_nf_conntrack_max, null)
            vm_max_map_count                   = try(sysctl_config.value.vm_max_map_count, null)
            vm_swappiness                      = try(sysctl_config.value.vm_swappiness, null)
            vm_vfs_cache_pressure              = try(sysctl_config.value.vm_vfs_cache_pressure, null)
          }
        }
        transparent_huge_page_defrag  = try(linux_os_config.value.transparent_huge_page_defrag, null)
        transparent_huge_page_enabled = try(linux_os_config.value.transparent_huge_page_enabled, null)
      }
    }
  }

  dns_prefix                 = try(var.settings.dns_prefix, try(var.settings.dns_prefix_private_cluster, random_string.prefix.result))
  dns_prefix_private_cluster = try(var.settings.dns_prefix_private_cluster, null)
  automatic_channel_upgrade  = try(var.settings.automatic_channel_upgrade, null)

  dynamic "key_management_service" {
    for_each = try(var.settings.key_management_service[*], {})
    content {
      key_vault_key_id         = key_management_service.value.key_vault_key_id
      key_vault_network_access = try(key_management_service.value.key_vault_network_access, null)
      #secret_rotation_enabled  = try(key_management_service.value.secret_rotation_enabled, null) # legacy?
      #secret_rotation_interval = try(key_management_service.value.secret_rotation_enabled, null) # legacy?
    }
  }

  dynamic "aci_connector_linux" {
    for_each = try(var.settings.addon_profile.aci_connector_linux[*], var.settings.aci_connector_linux[*], {})

    content {
      subnet_name = aci_connector_linux.value.subnet_name
    }
  }
  cost_analysis_enabled            = try(var.settings.cost_analysis_enabled, null)
  azure_policy_enabled             = can(var.settings.addon_profile.azure_policy) || can(var.settings.azure_policy_enabled) == false ? try(var.settings.addon_profile.azure_policy.0.enabled, null) : var.settings.azure_policy_enabled
  http_application_routing_enabled = can(var.settings.addon_profile.http_application_routing) || can(var.settings.http_application_routing_enabled) == false ? try(var.settings.addon_profile.http_application_routing.0.enabled, null) : var.settings.http_application_routing_enabled

  dynamic "oms_agent" {
    for_each = try(var.settings.addon_profile.oms_agent[*], var.settings.oms_agent[*], {})

    content {
      log_analytics_workspace_id      = can(oms_agent.value.log_analytics_workspace_id) ? oms_agent.value.log_analytics_workspace_id : var.diagnostics.log_analytics[oms_agent.value.log_analytics_key].id
      msi_auth_for_monitoring_enabled = try(oms_agent.value.msi_auth_for_monitoring_enabled, null)
    }
  }
  dynamic "microsoft_defender" {
    for_each = try(var.settings.microsoft_defender[*], var.settings.microsoft_defender[*], {})

    content {
      log_analytics_workspace_id = can(microsoft_defender.value.log_analytics_workspace_id) ? microsoft_defender.value.log_analytics_workspace_id : var.diagnostics.log_analytics[microsoft_defender.value.log_analytics_key].id
    }
  }

  dynamic "ingress_application_gateway" {
    for_each = can(var.settings.addon_profile.ingress_application_gateway) || can(var.settings.ingress_application_gateway) ? try([var.settings.addon_profile.ingress_application_gateway], [var.settings.ingress_application_gateway]) : []
    content {
      gateway_name = try(ingress_application_gateway.value.gateway_name, null)
      gateway_id   = try(ingress_application_gateway.value.gateway_id, try(var.application_gateway.id, null))
      subnet_cidr  = try(ingress_application_gateway.value.subnet_cidr, null)
      subnet_id    = try(ingress_application_gateway.value.subnet_id, null)
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = can(var.settings.addon_profile.azure_keyvault_secrets_provider) || can(var.settings.key_vault_secrets_provider) ? try([var.settings.addon_profile.azure_keyvault_secrets_provider], [var.settings.key_vault_secrets_provider]) : []
    content {
      secret_rotation_enabled  = try(key_vault_secrets_provider.value.secret_rotation_enabled, null)
      secret_rotation_interval = try(key_vault_secrets_provider.value.secret_rotation_interval, null)
    }
  }

  # dynamic "addon_profile" {
  #   for_each = lookup(var.settings, "addon_profile", null) == null ? [] : [1]
  #     dynamic "kube_dashboard" {
  #       for_each = try(var.settings.addon_profile.kube_dashboard[*], [{ enabled = false }])

  #       content {
  #         enabled = kube_dashboard.value.enabled
  #       }
  #     }

  api_server_authorized_ip_ranges = try(var.settings.api_server_authorized_ip_ranges, null)

  disk_encryption_set_id = try(coalesce(
    try(var.settings.disk_encryption_set_id, ""),
    try(var.settings.disk_encryption_set.id, "")
  ), null)

  dynamic "api_server_access_profile" {
    for_each = try(var.settings.api_server_access_profile[*], {})

    content {
      authorized_ip_ranges     = try(api_server_access_profile.value.authorized_ip_ranges, null)
      subnet_id                = try(can(api_server_access_profile.value.subnet_id) ? api_server_access_profile.value.subnet_id : var.vnets[try(api_server_access_profile.value.subnet.lz_key, var.settings.vnet.lz_key, var.settings.lz_key, var.client_config.landingzone_key)][try(api_server_access_profile.value.subnet.vnet_key, var.settings.vnet_key)].subnets[try(api_server_access_profile.value.subnet.key, var.settings.subnet_key)].id, null)
      vnet_integration_enabled = try(api_server_access_profile.value.vnet_integration_enabled, false)
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = try(var.settings.auto_scaler_profile[*], {})

    content {
      balance_similar_node_groups      = try(auto_scaler_profile.value.balance_similar_node_groups, null)
      expander                         = try(auto_scaler_profile.value.expander, null)
      max_graceful_termination_sec     = try(auto_scaler_profile.value.max_graceful_termination_sec, null)
      max_node_provisioning_time       = try(auto_scaler_profile.value.max_node_provisioning_time, null)
      max_unready_nodes                = try(auto_scaler_profile.value.max_unready_nodes, null)
      max_unready_percentage           = try(auto_scaler_profile.value.max_unready_percentage, null)
      new_pod_scale_up_delay           = try(auto_scaler_profile.value.new_pod_scale_up_delay, null)
      scale_down_delay_after_add       = try(auto_scaler_profile.value.scale_down_delay_after_add, null)
      scale_down_delay_after_delete    = try(auto_scaler_profile.value.scale_down_delay_after_delete, null)
      scale_down_delay_after_failure   = try(auto_scaler_profile.value.scale_down_delay_after_failure, null)
      scan_interval                    = try(auto_scaler_profile.value.scan_interval, null)
      scale_down_unneeded              = try(auto_scaler_profile.value.scale_down_unneeded, null)
      scale_down_unready               = try(auto_scaler_profile.value.scale_down_unready, null)
      scale_down_utilization_threshold = try(auto_scaler_profile.value.scale_down_utilization_threshold, null)
      empty_bulk_delete_max            = try(auto_scaler_profile.value.empty_bulk_delete_max, null)
      skip_nodes_with_local_storage    = try(auto_scaler_profile.value.skip_nodes_with_local_storage, null)
      skip_nodes_with_system_pods      = try(auto_scaler_profile.value.skip_nodes_with_system_pods, null)
    }
  }

  dynamic "identity" {
    for_each = try(var.settings.identity, null) == null ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = lower(var.settings.identity.type) == "userassigned" ? can(var.settings.identity.user_assigned_identity_id) ? [var.settings.identity.user_assigned_identity_id] : [var.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.identity.managed_identity_key].id] : null
    }
  }



  dynamic "kubelet_identity" {
    for_each = try(var.settings.kubelet_identity, null) == null ? [] : [1]
    content {
      client_id                 = can(kubelet_identity.value.client_id) ? kubelet_identity.value.client_id : var.managed_identities[try(var.settings.kubelet_identity.lz_key, var.client_config.landingzone_key)][var.settings.kubelet_identity.managed_identity_key].client_id
      object_id                 = can(kubelet_identity.value.object_id) ? kubelet_identity.value.object_id : var.managed_identities[try(var.settings.kubelet_identity.lz_key, var.client_config.landingzone_key)][var.settings.kubelet_identity.managed_identity_key].principal_id
      user_assigned_identity_id = can(kubelet_identity.value.user_assigned_identity_id) ? kubelet_identity.value.user_assigned_identity_id : var.managed_identities[try(var.settings.kubelet_identity.lz_key, var.client_config.landingzone_key)][var.settings.kubelet_identity.managed_identity_key].id
    }
  }

  kubernetes_version = try(var.settings.kubernetes_version, null)

  dynamic "linux_profile" {
    for_each = try(var.settings.linux_profile, null) == null ? [] : [1]
    content {
      admin_username = try(var.settings.linux_profile.admin_username, null)
      dynamic "ssh_key" {
        for_each = try(var.settings.linux_profile.ssh_key, null) == null ? [] : [1]
        content {
          key_data = try(var.settings.linux_profile.ssh_key.key_data, null)
        }
      }
    }
  }

  dynamic "storage_profile" {
    for_each = try(var.settings.storage_profile[*], {})
    content {
      blob_driver_enabled         = try(storage_profile.value.blob_driver_enabled, null)
      disk_driver_enabled         = try(storage_profile.value.disk_driver_enabled, null)
      disk_driver_version         = try(storage_profile.value.disk_driver_version, null)
      file_driver_enabled         = try(storage_profile.value.file_driver_enabled, null)
      snapshot_controller_enabled = try(storage_profile.value.snapshot_controller_enabled, null)
    }
  }

  local_account_disabled = try(var.settings.local_account_disabled, false)

  dynamic "maintenance_window" {
    for_each = try(var.settings.maintenance_window, null) == null ? [] : [1]
    content {
      dynamic "allowed" {
        for_each = try(var.settings.maintenance_window.allowed, null) == null ? [] : [1]
        content {
          day   = var.settings.maintenance_window.allowed.day
          hours = var.settings.maintenance_window.allowed.hours
        }
      }
      dynamic "not_allowed" {
        for_each = try(var.settings.maintenance_window.not_allowed, null) == null ? [] : [1]
        content {
          end   = var.settings.maintenance_window.not_allowed.end
          start = var.settings.maintenance_window.not_allowed.start
        }
      }
    }
  }

  dynamic "network_profile" {
    for_each = try(var.settings.network_profile[*], {})
    content {
      network_plugin      = try(network_profile.value.network_plugin, null)
      network_mode        = try(network_profile.value.network_mode, null)
      network_policy      = try(network_profile.value.network_policy, null)
      dns_service_ip      = try(network_profile.value.dns_service_ip, null)
      docker_bridge_cidr  = try(network_profile.value.docker_bridge_cidr, null)
      outbound_type       = try(network_profile.value.outbound_type, null)
      pod_cidr            = try(network_profile.value.pod_cidr, null)
      service_cidr        = try(network_profile.value.service_cidr, null)
      service_cidrs       = try(network_profile.value.network_cidrs, null)
      load_balancer_sku   = try(network_profile.value.load_balancer_sku, null)
      ebpf_data_plane     = try(network_profile.value.ebpf_data_plane, null)
      network_plugin_mode = try(network_profile.value.network_plugin_mode, null)
      ip_versions         = try(network_profile.value.ip_versions, null)

      dynamic "load_balancer_profile" {
        for_each = try(network_profile.value.load_balancer_profile[*], {})
        content {
          idle_timeout_in_minutes     = try(load_balancer_profile.value.idle_timeout_in_minutes, null)
          managed_outbound_ip_count   = try(load_balancer_profile.value.managed_outbound_ip_count, null)
          managed_outbound_ipv6_count = try(load_balancer_profile.value.managed_outbound_ipv6_count, null)
          outbound_ip_address_ids     = try(load_balancer_profile.value.outbound_ip_address_ids, null)
          outbound_ip_prefix_ids      = try(load_balancer_profile.value.outbound_ip_prefix_ids, null)
          outbound_ports_allocated    = try(load_balancer_profile.value.outbound_ports_allocated, null)
        }
      }
    }
  }

  dynamic "service_mesh_profile" {
    for_each = try(var.settings.service_mesh_profile[*], {})
    content {
      mode                             = try(service_mesh_profile.value.mode, null)
      internal_ingress_gateway_enabled = try(service_mesh_profile.value.internal_ingress_gateway_enabled, null)
      external_ingress_gateway_enabled = try(service_mesh_profile.value.external_ingress_gateway_enabled, null)
    }
  }

  node_resource_group                 = azurecaf_name.rg_node.result
  oidc_issuer_enabled                 = try(var.settings.oidc_issuer_enabled, null)
  open_service_mesh_enabled           = try(var.settings.open_service_mesh_enabled, null)
  private_cluster_enabled             = try(var.settings.private_cluster_enabled, null)
  private_dns_zone_id                 = try(var.private_dns_zone_id, null)
  private_cluster_public_fqdn_enabled = try(var.settings.private_cluster_public_fqdn_enabled, null)
  public_network_access_enabled       = try(var.settings.public_network_access_enabled, true)

  #Enabled RBAC
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = try(var.settings.role_based_access_control[*], {})

    content {
      managed   = try(azure_active_directory_role_based_access_control.value.azure_active_directory.managed, true)
      tenant_id = try(azure_active_directory_role_based_access_control.value.azure_active_directory.tenant_id, null)

      azure_rbac_enabled     = try(azure_active_directory_role_based_access_control.value.enabled, true)
      admin_group_object_ids = try(azure_active_directory_role_based_access_control.value.azure_active_directory.admin_group_object_ids, try(var.admin_group_object_ids, null))

      client_app_id     = try(azure_active_directory_role_based_access_control.value.azure_active_directory.client_app_id, null)
      server_app_id     = try(azure_active_directory_role_based_access_control.value.azure_active_directory.server_app_id, null)
      server_app_secret = try(azure_active_directory_role_based_access_control.value.azure_active_directory.server_app_secret, null)

    }
  }

  dynamic "service_principal" {
    for_each = try(var.settings.service_principal[*], {})
    content {
      client_id     = var.settings.service_principal.client_id
      client_secret = var.settings.service_principal.client_secret
    }
  }

  sku_tier = try(var.settings.sku_tier, null)


  lifecycle {
    ignore_changes = [
      windows_profile, private_dns_zone_id
    ]
  }
  tags = merge(local.tags, lookup(var.settings, "tags", {}))

  dynamic "windows_profile" {
    for_each = try(var.settings.windows_profile[*], {})
    content {
      admin_username = var.settings.windows_profile.admin_username
      admin_password = var.settings.windows_profile.admin_password
      license        = try(var.settings.windows_profile.license, null)
      dynamic "gmsa" {
        for_each = try(windows_profile.gmsa[*], {})
        content {
          dns_server  = try(gmsa.value.dns_server, null)
          root_domain = try(gmsa.value.root_domain, null)
        }
      }
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = try(var.settings.workload_autoscaler_profile[*], {})
    content {
      keda_enabled = try(workload_autoscaler_profile.value.keda_enabled, null)
    }
  }

  workload_identity_enabled = try(var.settings.workload_identity_enabled, null)

  dynamic "http_proxy_config" {
    for_each = try(var.settings.http_proxy_config[*], {})

    content {
      http_proxy  = try(http_proxy_config.value.http_proxy, null)
      https_proxy = try(http_proxy_config.value.https_proxy, null)
      no_proxy    = try(http_proxy_config.value.no_proxy, null)
      trusted_ca  = try(http_proxy_config.value.trusted_ca, null)
    }
  }
  dynamic "web_app_routing" {
    for_each = try(var.settings.web_app_routing[*], {})

    content {
      dns_zone_id = try(web_app_routing.value.dns_zone_id, null)
    }
  }
}

resource "random_string" "prefix" {
  length  = 10
  special = false
  upper   = false
  numeric = false
}

#
# Node pools
#

resource "azurerm_kubernetes_cluster_node_pool" "nodepools" {
  for_each = try(var.settings.node_pools, {})

  name                          = each.value.name
  kubernetes_cluster_id         = azurerm_kubernetes_cluster.aks.id
  vm_size                       = each.value.vm_size
  capacity_reservation_group_id = try(each.value.capacity_reservation_group_id, null)
  custom_ca_trust_enabled       = try(each.value.custom_ca_trust_enabled, null)
  zones                         = try(each.value.zones, each.value.availability_zones, null)
  enable_auto_scaling           = try(each.value.enable_auto_scaling, false)
  enable_host_encryption        = try(each.value.enable_host_encryption, false)
  enable_node_public_ip         = try(each.value.enable_node_public_ip, false)
  eviction_policy               = try(each.value.eviction_policy, null)
  host_group_id                 = try(each.value.host_group_id, null)

  dynamic "kubelet_config" {
    for_each = try(each.value.kubelet_config, null) == null ? [] : [1]
    content {
      allowed_unsafe_sysctls    = try(kubelet_config.value.allowed_unsafe_sysctls, null)
      container_log_max_line    = try(kubelet_config.value.container_log_max_line, null)
      container_log_max_size_mb = try(kubelet_config.value.container_log_max_size_mb, null)
      cpu_cfs_quota_enabled     = try(kubelet_config.value.cpu_cfs_quota_enabled, null)
      cpu_cfs_quota_period      = try(kubelet_config.value.cpu_cfs_quota_period, null)
      cpu_manager_policy        = try(kubelet_config.value.cpu_manager_policy, null)
      image_gc_high_threshold   = try(kubelet_config.value.image_gc_high_threshold, null)
      image_gc_low_threshold    = try(kubelet_config.value.image_gc_low_threshold, null)
      pod_max_pid               = try(kubelet_config.value.pod_max_pid, null)
      topology_manager_policy   = try(kubelet_config.value.topology_manager_policy, null)
    }
  }
  dynamic "linux_os_config" {
    for_each = try(each.value.linux_os_config, null) == null ? [] : [1]
    content {
      swap_file_size_mb = try(linux_os_config.value.allowed_unsafe_sysctls, null)
      dynamic "sysctl_config" {
        for_each = try(linux_os_config.value.sysctl_config, null) == null ? [] : [1]
        content {
          fs_aio_max_nr                      = try(sysctl_config.value.fs_aio_max_nr, null)
          fs_file_max                        = try(sysctl_config.value.fs_file_max, null)
          fs_inotify_max_user_watches        = try(sysctl_config.value.fs_inotify_max_user_watches, null)
          fs_nr_open                         = try(sysctl_config.value.fs_nr_open, null)
          kernel_threads_max                 = try(sysctl_config.value.kernel_threads_max, null)
          net_core_netdev_max_backlog        = try(sysctl_config.value.net_core_netdev_max_backlog, null)
          net_core_optmem_max                = try(sysctl_config.value.net_core_optmem_max, null)
          net_core_rmem_default              = try(sysctl_config.value.net_core_rmem_default, null)
          net_core_rmem_max                  = try(sysctl_config.value.net_core_rmem_max, null)
          net_core_somaxconn                 = try(sysctl_config.value.net_core_somaxconn, null)
          net_core_wmem_default              = try(sysctl_config.value.net_core_wmem_default, null)
          net_core_wmem_max                  = try(sysctl_config.value.net_core_wmem_max, null)
          net_ipv4_ip_local_port_range_max   = try(sysctl_config.value.net_ipv4_ip_local_port_range_max, null)
          net_ipv4_ip_local_port_range_min   = try(sysctl_config.value.net_ipv4_ip_local_port_range_min, null)
          net_ipv4_neigh_default_gc_thresh1  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh1, null)
          net_ipv4_neigh_default_gc_thresh2  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh2, null)
          net_ipv4_neigh_default_gc_thresh3  = try(sysctl_config.value.net_ipv4_neigh_default_gc_thresh3, null)
          net_ipv4_tcp_fin_timeout           = try(sysctl_config.value.net_ipv4_tcp_fin_timeout, null)
          net_ipv4_tcp_keepalive_intvl       = try(sysctl_config.value.net_ipv4_tcp_keepalive_intvl, null)
          net_ipv4_tcp_keepalive_probes      = try(sysctl_config.value.net_ipv4_tcp_keepalive_probes, null)
          net_ipv4_tcp_keepalive_time        = try(sysctl_config.value.net_ipv4_tcp_keepalive_time, null)
          net_ipv4_tcp_max_syn_backlog       = try(sysctl_config.value.net_ipv4_tcp_max_syn_backlog, null)
          net_ipv4_tcp_max_tw_buckets        = try(sysctl_config.value.net_ipv4_tcp_max_tw_buckets, null)
          net_ipv4_tcp_tw_reuse              = try(sysctl_config.value.net_ipv4_tcp_tw_reuse, null)
          net_netfilter_nf_conntrack_buckets = try(sysctl_config.value.net_netfilter_nf_conntrack_buckets, null)
          net_netfilter_nf_conntrack_max     = try(sysctl_config.value.net_netfilter_nf_conntrack_max, null)
          vm_max_map_count                   = try(sysctl_config.value.vm_max_map_count, null)
          vm_swappiness                      = try(sysctl_config.value.vm_swappiness, null)
          vm_vfs_cache_pressure              = try(sysctl_config.value.vm_vfs_cache_pressure, null)
        }
      }
      transparent_huge_page_defrag  = try(linux_os_config.value.transparent_huge_page_defrag, null)
      transparent_huge_page_enabled = try(linux_os_config.value.transparent_huge_page_enabled, null)
    }
  }

  fips_enabled       = try(each.value.fips_enabled, false)
  kubelet_disk_type  = try(each.value.kubelet_disk_type, null)
  max_pods           = try(each.value.max_pods, null)
  message_of_the_day = try(each.value.message_of_the_day, null)

  dynamic "node_network_profile" {
    for_each = try(var.settings.node_network_profile[*], {})

    content {
      node_public_ip_tags = try(each.value.node_network_profile, null)
    }
  }

  mode                     = try(each.value.mode, "User")
  node_labels              = try(each.value.node_labels, null)
  node_public_ip_prefix_id = try(each.value.node_public_ip_prefix_id, null)
  node_taints              = try(each.value.node_taints, null)
  orchestrator_version     = try(each.value.orchestrator_version, try(var.settings.kubernetes_version, null))
  os_disk_size_gb          = try(each.value.os_disk_size_gb, null)
  os_disk_type             = try(each.value.os_disk_type, null)
  pod_subnet_id            = can(each.value.pod_subnet_key) == false || can(each.value.pod_subnet.key) == false || can(each.value.pod_subnet_id) || can(each.value.pod_subnet.resource_id) ? try(each.value.pod_subnet_id, each.value.pod_subnet.resource_id, null) : var.vnets[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.vnet_key].subnets[try(each.value.pod_subnet.key, each.value.pod_subnet_key)].id

  os_sku                       = try(each.value.os_sku, null)
  os_type                      = try(each.value.os_type, null)
  priority                     = try(each.value.priority, null)
  proximity_placement_group_id = try(each.value.proximity_placement_group_id, null)
  spot_max_price               = try(each.value.spot_max_price, null)
  tags                         = merge(try(var.settings.default_node_pool.tags, {}), try(each.value.tags, {}))
  scale_down_mode              = try(each.value.scale_down_mode, null)
  ultra_ssd_enabled            = try(each.value.ultra_ssd_enabled, false)
  dynamic "upgrade_settings" {
    for_each = try(each.value.upgrade_settings, null) == null ? [] : [1]
    content {
      max_surge = upgrade_settings.value.max_surge
    }
  }

  vnet_subnet_id = can(each.value.subnet.resource_id) || can(each.value.vnet_subnet_id) ? try(each.value.subnet.resource_id, each.value.vnet_subnet_id) : var.vnets[try(var.settings.vnet.lz_key, var.settings.lz_key, var.client_config.landingzone_key)][try(var.settings.vnet.key, var.settings.vnet_key)].subnets[try(each.value.subnet.key, each.value.subnet_key)].id

  dynamic "windows_profile" {
    for_each = try(each.value.windows_profile[*], {})
    content {
      outbound_nat_enabled = try(windows_profile.value.outbound_nat_enabled, null)
    }
  }

  workload_runtime = try(each.value.workload_runtime, null)

  max_count  = try(each.value.max_count, null)
  min_count  = try(each.value.min_count, null)
  node_count = try(each.value.node_count, null)
}

