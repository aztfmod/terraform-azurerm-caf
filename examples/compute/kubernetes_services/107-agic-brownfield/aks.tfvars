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

    # enable_rbac = true
    #azure_active_directory_role_based_access_control = {
    #  enabled = true
    #  tenant_id = "00000000-0000-0000-0000-000000000000"
    #  admin_group_object_ids = ["00000000-0000-0000-0000-000000000000"]
    #}

    addon_profile = {
      oms_agent = {
        enabled           = true
        log_analytics_key = "central_logs_region1"
      }
      ingress_application_gateway = {
        enabled = true
        key     = "agw"
      }
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
      name                         = "sharedsvc"
      vm_size                      = "Standard_F4s_v2"
      subnet_key                   = "aks_nodepool_system"
      enabled_auto_scaling         = false
      enable_node_public_ip        = false
      max_pods                     = 30
      node_count                   = 1
      os_disk_size_gb              = 512
      only_critical_addons_enabled = false # when using ingress_application_gateway and ingress_application_gateway=true you need an additional node_pool as agic is a non-critical addon
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

  }
}
