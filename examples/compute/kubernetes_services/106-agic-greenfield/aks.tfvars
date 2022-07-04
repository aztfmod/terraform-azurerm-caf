global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
}

managed_identities = {
  aks_usermsi = {
    name               = "aks-useraccess"
    resource_group_key = "aks_re1"
  }
}

aks_clusters = {
  cluster_re1 = {
    name                     = "akscluster-re1-001"
    resource_group_key       = "aks_re1"
    os_type                  = "Linux"
    node_resource_group_name = "aks-nodes-re1"

    identity = {
      type                 = "UserAssigned"
      managed_identity_key = "aks_usermsi"
    }

    vnet_key = "spoke_aks_re1"

    network_profile = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    role_based_access_control = {
      enabled = true
      azure_active_directory = {
        managed            = true
        azure_rbac_enabled = true
      }
    }

    addon_profile = {
      oms_agent = {
        enabled           = true
        log_analytics_key = "central_logs_region1"
      }
      ingress_application_gateway = {
        enabled      = true
        gateway_name = "agw1_az1"
        vnet = {
          # lz_key = ""
          key          = "spoke_aks_re1"
          subnet_key   = "application_gateway"
        }
      }
    }

    load_balancer_profile = {
      managed_outbound_ip_count = 1
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
    }
  }
}
