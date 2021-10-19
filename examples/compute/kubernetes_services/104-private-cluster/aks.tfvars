aks_clusters = {
  cluster_re1 = {
    name               = "akscluster-001"
    resource_group_key = "aks_re1"
    os_type            = "Linux"

    diagnostic_profiles = {
      operations = {
        name             = "aksoperations"
        definition_key   = "azure_kubernetes_cluster"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
    identity = {
      type = "SystemAssigned"
    }

    vnet_key = "spoke_aks_re1"

    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    private_cluster_enabled = true
    enable_rbac             = true
    outbound_type           = "userDefinedRouting"

    admin_groups = {
      # ids = []
      # azuread_group_keys = ["aks_admins"]
    }
    private_cluster_public_fqdn_enabled = true
    load_balancer_profile = {
      # Only one option can be set
      managed_outbound_ip_count = 1
    }

    default_node_pool = {
      name                  = "sharedsvc"
      vm_size               = "Standard_F4s_v2"
      subnet_key            = "aks_nodepool_system"
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 2
      os_disk_size_gb       = 512
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

    node_pools = {
      pool1 = {
        name                = "nodepool1"
        mode                = "User"
        subnet_key          = "aks_nodepool_user1"
        max_pods            = 30
        vm_size             = "Standard_DS2_v2"
        node_count          = 2
        enable_auto_scaling = false
        os_disk_size_gb     = 512
        tags = {
          "project" = "user services"
        }
      }
    }

  }
}
