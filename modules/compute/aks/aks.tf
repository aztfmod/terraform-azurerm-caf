### Naming convention

resource "azurecaf_name" "aks" {
  name          = var.settings.name
  resource_type = "azurerm_kubernetes_cluster"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "default_node_pool" {
  name          = var.settings.default_node_pool.name
  resource_type = "aks_node_pool_linux"
  prefixes      = [var.global_settings.prefix]
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
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

### AKS cluster resource

resource "azurerm_kubernetes_cluster" "aks" {

  name                    = azurecaf_name.aks.result
  location                = var.resource_group.location
  resource_group_name     = var.resource_group.name
  dns_prefix              = try(var.settings.dns_prefix, random_string.prefix.result)
  kubernetes_version      = try(var.settings.kubernetes_version, null)
  node_resource_group     = azurecaf_name.rg_node.result
  private_cluster_enabled = try(var.settings.private_cluster_enabled, false)

  network_profile {

    network_plugin    = var.settings.network_policy.network_plugin
    load_balancer_sku = var.settings.network_policy.load_balancer_sku

    # load_balancer_profile {
    #   managed_outbound_ip_count = lookup(var.settings.load_balancer_profile, "managed_outbound_ip_count", null)
    #   outbound_ip_prefix_ids    = lookup(var.settings.load_balancer_profile, "outbound_ip_prefix_ids", null)
    #   outbound_ip_address_ids   = lookup(var.settings.load_balancer_profile, "outbound_ip_address_ids", null)
    # }

    outbound_type = try(var.settings.outbound_type, "loadBalancer")
  }


  dynamic "default_node_pool" {

    for_each = var.settings.default_node_pool == null ? [0] : [1]

    content {
      name                  = var.settings.default_node_pool.name //azurecaf_name.default_node_pool.result
      vm_size               = var.settings.default_node_pool.vm_size
      type                  = try(var.settings.default_node_pool.type, "VirtualMachineScaleSets")
      os_disk_size_gb       = try(var.settings.default_node_pool.os_disk_size_gb, null)
      availability_zones    = try(var.settings.default_node_pool.availability_zones, null)
      enable_auto_scaling   = try(var.settings.default_node_pool.enable_auto_scaling, false)
      enable_node_public_ip = try(var.settings.default_node_pool.enable_node_public_ip, false)
      node_count            = try(var.settings.default_node_pool.node_count, 1)
      max_pods              = try(var.settings.default_node_pool.max_pods, 30)
      node_labels           = try(var.settings.default_node_pool.node_labels, null)
      node_taints           = try(var.settings.default_node_pool.node_taints, null)
      vnet_subnet_id        = var.subnets[var.settings.default_node_pool.subnet_key].id
      orchestrator_version  = try(var.settings.default_node_pool.orchestrator_version, var.settings.kubernetes_version)
      tags                  = merge(try(var.settings.default_node_pool.tags, {}), local.tags)
    }

  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", null) == null ? [] : [1]

    content {
      type = var.settings.identity.type
    }
  }

  # Enabled RBAC
  role_based_access_control {
    enabled = lookup(var.settings, "enable_rbac", true)
    azure_active_directory {
      managed                = true
      admin_group_object_ids = var.admin_group_ids
    }
  }

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
  vnet_subnet_id        = var.subnets[var.settings.default_node_pool.subnet_key].id
  vm_size               = each.value.vm_size
  os_disk_size_gb       = try(each.value.os_disk_size_gb, null)
  availability_zones    = try(each.value.availability_zones, null)
  enable_auto_scaling   = try(each.value.enable_auto_scaling, false)
  enable_node_public_ip = try(each.value.enable_node_public_ip, false)
  node_count            = try(each.value.node_count, 1)
  max_pods              = try(each.value.max_pods, 30)
  node_labels           = try(each.value.node_labels, null)
  node_taints           = try(each.value.node_taints, null)
  orchestrator_version  = try(each.value.orchestrator_version, var.settings.kubernetes_version)
  tags                  = merge(try(each.value.tags, {}), try(var.settings.default_node_pool.tags, {}))

}

#
# Preview features
#
locals {
  register_aks_msi_preview_feature_command = <<EOT
    az feature register -n AAD-V2 --namespace Microsoft.ContainerService

    isRegistered=$(az feature list --query properties.state=="Registered")

    while [ ! $isRegistered == true ]
    do
      echo "waiting for the provider to register"
      sleep 20
      isRegistered=$(az feature list --query properties.state=="Registered")
    done
    echo "Feature registered"
    az provider register -n Microsoft.ContainerService
  EOT
}


# Can take around 30 mins to register the feature
resource "null_resource" "register_aks_msi_preview_feature" {
  provisioner "local-exec" {
    command = local.register_aks_msi_preview_feature_command
  }

  triggers = {
    command = sha256(local.register_aks_msi_preview_feature_command)
  }
}