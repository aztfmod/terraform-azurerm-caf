aks_clusters = {
  cluster_re1 = {
    name               = "akscluster-re1-001"
    resource_group_key = "aks_re1"
    os_type            = "Linux"

    identity = {
      type = "SystemAssigned"
    }

    # kubernetes_version = "1.19.6"

    vnet_key = "spoke_aks_re1"


    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    enable_rbac = true

    admin_groups = {
      # ids = []
      azuread_group_keys = []
    }

    load_balancer_profile = {
      # Only one option can be set
      managed_outbound_ip_count = 1
      # outbound_ip_prefix_ids = []
      # outbound_ip_address_ids = []
    }

    default_node_pool = {
      name                  = "sharedsvc"
      vm_size               = "Standard_F4s_v2"
      subnet_key            = "aks_nodepool_system"
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      availability_zones    = ["1", "2", "3"]
      max_pods              = 30
      node_count            = 3
      os_disk_size_gb       = 512
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_kubernetes_cluster"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  cluster_re2 = {
    name               = "akscluster-re2-001"
    resource_group_key = "aks_re2"
    os_type            = "Linux"

    identity = {
      type = "SystemAssigned"
    }

    vnet_key = "spoke_aks_re2"

    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    enable_rbac = true

    admin_groups = {
      # ids = []
      azuread_group_keys = []
    }

    load_balancer_profile = {
      # Only one option can be set
      managed_outbound_ip_count = 1
      # outbound_ip_prefix_ids = []
      # outbound_ip_address_ids = []
    }

    default_node_pool = {
      name                  = "sharedsvc"
      vm_size               = "Standard_F4s_v2"
      subnet_key            = "aks_nodepool_system"
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 3
      os_disk_size_gb       = 512
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re2"

    diagnostic_profiles = {
      central_logs_region2 = {
        definition_key   = "azure_kubernetes_cluster"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}