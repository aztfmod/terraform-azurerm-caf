global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
}

aks_clusters = {
  cluster_re1 = {
    name               = "akscluster-re1-001"
    resource_group_key = "aks_re1"
    os_type            = "Linux"

    identity = {
      type = "SystemAssigned"
    }

    kubernetes_version = "1.17.11"
    vnet_key           = "spoke_aks_re1"

    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    enable_rbac = true

    # admin_groups = {
    #   # ids = []
    #   # azuread_groups = {
    #   #   keys = []
    #   # }
    # }

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
      node_count            = 1
      os_disk_size_gb       = 512
      orchestrator_version  = "1.17.11"
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

  }
}