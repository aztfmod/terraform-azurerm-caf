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

  name                = azurecaf_name.aks.result
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  default_node_pool {
    name                         = var.settings.default_node_pool.name //azurecaf_name.default_node_pool.result
    vm_size                      = var.settings.default_node_pool.vm_size
    type                         = try(var.settings.default_node_pool.type, "VirtualMachineScaleSets")
    os_disk_size_gb              = try(var.settings.default_node_pool.os_disk_size_gb, null)
    os_disk_type                 = try(var.settings.default_node_pool.os_disk_type, null)
    availability_zones           = try(var.settings.default_node_pool.availability_zones, null)
    enable_auto_scaling          = try(var.settings.default_node_pool.enable_auto_scaling, false)
    enable_node_public_ip        = try(var.settings.default_node_pool.enable_node_public_ip, false)
    only_critical_addons_enabled = try(var.settings.default_node_pool.only_critical_addons_enabled, false)
    node_count                   = try(var.settings.default_node_pool.node_count, 1)
    max_pods                     = try(var.settings.default_node_pool.max_pods, 30)
    node_labels                  = try(var.settings.default_node_pool.node_labels, null)
    node_taints                  = try(var.settings.default_node_pool.node_taints, null)
    orchestrator_version         = try(var.settings.default_node_pool.orchestrator_version, try(var.settings.kubernetes_version, null))
    tags                         = merge(try(var.settings.default_node_pool.tags, {}), local.tags)
    vnet_subnet_id = coalesce(
      try(var.subnets[var.settings.default_node_pool.subnet_key].id, ""),
      try(var.subnets[var.settings.default_node_pool.subnet.key].id, ""),
      try(var.settings.default_node_pool.subnet.resource_id, "")
    )
  }

  dns_prefix = try(var.settings.dns_prefix, random_string.prefix.result)

  dynamic "addon_profile" {
    for_each = lookup(var.settings, "addon_profile", null) == null ? [] : [1]

    content {
      dynamic "aci_connector_linux" {
        for_each = try(var.settings.addon_profile.aci_connector_linux[*], {})

        content {
          enabled     = aci_connector_linux.value.enabled
          subnet_name = aci_connector_linux.value.subnet_name
        }
      }

      dynamic "azure_policy" {
        for_each = try(var.settings.addon_profile.azure_policy[*], {})

        content {
          enabled = azure_policy.value.enabled
        }
      }

      dynamic "http_application_routing" {
        for_each = try(var.settings.addon_profile.http_application_routing[*], {})

        content {
          enabled = http_application_routing.value.enabled
        }
      }

      dynamic "kube_dashboard" {
        for_each = try(var.settings.addon_profile.kube_dashboard[*], [{ enabled = false }])

        content {
          enabled = kube_dashboard.value.enabled
        }
      }

      dynamic "oms_agent" {
        for_each = try(var.settings.addon_profile.oms_agent[*], {})

        content {
          enabled                    = oms_agent.value.enabled
          log_analytics_workspace_id = try(oms_agent.value.log_analytics_workspace_id, try(var.diagnostics.log_analytics[oms_agent.value.log_analytics_key].id, null))
          dynamic "oms_agent_identity" {
            for_each = try(oms_agent.value.oms_agent_identity[*], {})

            content {
              client_id                 = oms_agent_identity.value.client_id
              object_id                 = oms_agent_identity.value.object_id
              user_assigned_identity_id = oms_agent_identity.value.user_assigned_identity_id
            }
          }
        }
      }
    }
  }

  api_server_authorized_ip_ranges = try(var.settings.api_server_authorized_ip_ranges, null)

  dynamic "auto_scaler_profile" {
    for_each = try(var.settings.auto_scaler_profile[*], {})

    content {
      balance_similar_node_groups      = try(auto_scaler_profile.value.balance_similar_node_groups, null)
      max_graceful_termination_sec     = try(auto_scaler_profile.value.max_graceful_termination_sec, null)
      scale_down_delay_after_add       = try(auto_scaler_profile.value.scale_down_delay_after_add, null)
      scale_down_delay_after_delete    = try(auto_scaler_profile.value.scale_down_delay_after_delete, null)
      scale_down_delay_after_failure   = try(auto_scaler_profile.value.scale_down_delay_after_failure, null)
      scan_interval                    = try(auto_scaler_profile.value.scan_interval, null)
      scale_down_unneeded              = try(auto_scaler_profile.value.scale_down_unneeded, null)
      scale_down_unready               = try(auto_scaler_profile.value.scale_down_unready, null)
      scale_down_utilization_threshold = try(auto_scaler_profile.value.scale_down_utilization_threshold, null)
    }
  }

  disk_encryption_set_id = try(var.settings.disk_encryption_set_id, null)

  dynamic "identity" {
    for_each = try(var.settings.identity[*], {})

    content {
      type = identity.value.type
    }
  }

  # Enabled RBAC
  dynamic "role_based_access_control" {
    for_each = try(var.settings.role_based_access_control[*], {})

    content {
      enabled = try(role_based_access_control.value.enabled, true)

      dynamic "azure_active_directory" {
        for_each = try(var.settings.role_based_access_control.azure_active_directory[*], {})

        content {
          managed                = azure_active_directory.value.managed
          tenant_id              = try(azure_active_directory.value.tenant_id, null)
          admin_group_object_ids = try(azure_active_directory.value.admin_group_object_ids, try(var.admin_group_object_ids, null))
          client_app_id          = try(azure_active_directory.value.client_app_id, null)
          server_app_id          = try(azure_active_directory.value.server_app_id, null)
          server_app_secret      = try(azure_active_directory.value.server_app_secret, null)
        }
      }
    }
  }
  sku_tier           = try(var.settings.sku_tier, null)
  kubernetes_version = try(var.settings.kubernetes_version, null)

  # dynamic "linux_profile" {
  #   for_each = var.settings.linux_profile == null ? [] : [1]

  #   content {
  #     admin_username  = try(var.settings.linux_profile.admin_username,null)
  #     ssh_key         = try(var.settings.linux_profile.ssh_key,null)
  #   }
  # }

  dynamic "network_profile" {
    for_each = try(var.settings.network_profile[*], {})
    content {
      network_plugin     = try(network_profile.value.network_plugin, null)
      network_mode       = try(network_profile.value.network_mode, null)
      network_policy     = try(network_profile.value.network_policy, null)
      dns_service_ip     = try(network_profile.value.dns_service_ip, null)
      docker_bridge_cidr = try(network_profile.value.docker_bridge_cidr, null)
      outbound_type      = try(network_profile.value.outbound_type, null)
      pod_cidr           = try(network_profile.value.network_profile.pod_cidr, null)
      service_cidr       = try(network_profile.value.network_profile.service_cidr, null)
      load_balancer_sku  = try(network_profile.value.network_profile.load_balancer_sku, null)

      dynamic "load_balancer_profile" {
        for_each = try(network_profile.value.load_balancer_profile[*], {})
        content {
          managed_outbound_ip_count = try(load_balancer_profile.value.managed_outbound_ip_count, null)
          outbound_ip_prefix_ids    = try(load_balancer_profile.value.outbound_ip_prefix_ids, null)
          outbound_ip_address_ids   = try(load_balancer_profile.value.outbound_ip_address_ids, null)
        }
      }
    }
  }

  node_resource_group     = azurecaf_name.rg_node.result
  private_cluster_enabled = try(var.settings.private_cluster_enabled, false)

  lifecycle {
    ignore_changes = [
      windows_profile,
    ]
  }
  tags = merge(local.tags, lookup(var.settings, "tags", {}))
}

resource "random_string" "prefix" {
  length  = 10
  special = false
  upper   = false
  number  = false
}

#
# Node pools
#

resource "azurerm_kubernetes_cluster_node_pool" "nodepools" {
  for_each = try(var.settings.node_pools, {})

  name                  = each.value.name
  mode                  = try(each.value.mode, "User")
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  os_disk_size_gb       = try(each.value.os_disk_size_gb, null)
  os_disk_type          = try(each.value.os_disk_type, null)
  availability_zones    = try(each.value.availability_zones, null)
  enable_auto_scaling   = try(each.value.enable_auto_scaling, false)
  enable_node_public_ip = try(each.value.enable_node_public_ip, false)
  node_count            = try(each.value.node_count, 1)
  max_pods              = try(each.value.max_pods, 30)
  node_labels           = try(each.value.node_labels, null)
  node_taints           = try(each.value.node_taints, null)
  orchestrator_version  = try(each.value.orchestrator_version, try(var.settings.kubernetes_version, null))
  tags                  = merge(try(var.settings.default_node_pool.tags, {}), try(each.value.tags, {}))
  vnet_subnet_id = coalesce(
    try(var.subnets[each.value.subnet_key].id, ""),
    try(var.subnets[each.value.subnet.key].id, ""),
    try(each.value.subnet.resource_id, "")
  )
}
