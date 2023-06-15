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
    name               = "akscluster-re1-001"
    resource_group_key = "aks_re1"
    os_type            = "Linux"

    identity = {
      type                 = "UserAssigned"
      managed_identity_key = "aks_usermsi"
    }

    vnet_key = "spoke_aks_re1"

    network_profile = {
      network_plugin    = "azure"
      load_balancer_sku = "standard"
    }

    azure_active_directory_role_based_access_control = {
      managed            = true
      azure_rbac_enabled = true
      # tenant_id = ""
      # admin_group_object_ids = ""

      # when managed to set to false
      # client_app_id = ""
      # server_app_id = ""
      # server_app_secret = ""
    }

    # Replace with azure_active_directory_role_based_access_control
    # Still supported for backward compatibility
    # role_based_access_control = {
    #   enabled = true
    #   azure_active_directory = {
    #     managed = true
    #   }
    # }

    oms_agent = {
      log_analytics_key = "central_logs_region1"
    }

    # admin_groups = {
    #   # ids = []
    #   # azuread_groups = {
    #   #   keys = []
    #   # }
    # }

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
      node_count            = 1
      os_disk_size_gb       = 512
      zones                 = [1]
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

  }
}