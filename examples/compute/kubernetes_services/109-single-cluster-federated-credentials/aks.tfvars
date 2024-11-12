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
  msi_region1 = {
    name   = "security-rg1"
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

    vnet_key = "spoke_aks_re1"

    network_profile = {
      network_plugin    = "azure"
      load_balancer_sku = "standard"
    }

    # enable_rbac = true
    role_based_access_control = {
      enabled = true
      azure_active_directory = {
        managed = true
      }
    }

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
      name    = "sharedsvc"
      vm_size = "Standard_F4s_v2"
      #subnet_key            = "aks_nodepool_system"
      subnet = {
        key = "aks_nodepool_system"
        #resource_id = "/subscriptions/97958dac-xxxx-xxxx-xxxx-9f436fa73bd4/resourceGroups/qxgc-rg-aks-re1/providers/Microsoft.Network/virtualNetworks/qxgc-vnet-aks/subnets/qxgc-snet-aks_nodepool_system"
      }
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 1
      os_disk_size_gb       = 512
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

    addon_profile = {
      azure_keyvault_secrets_provider = {
        secret_rotation_enabled  = true
        secret_rotation_interval = "2m"
      }
    }
    azuread_federated_credentials = {
      cred1 = {
        display_name = "app-wi-fed02"
        subject      = "system:serviceaccount:demo:workload-identity-sa"
        azuread_application = {
          key = "aks_auth_app"
          #lz_key = ""
        }
      }
    }

    mi_federated_credentials = {
      cred1 = {
        name    = "mi-wi-demo02"
        subject = "system:serviceaccount:demo:workload-identity-sa"
        managed_identity = {
          key = "workload_system_mi"
          #lz_key = ""
        }
      }
    }
  }
}

azuread_applications = {
  aks_auth_app = {
    application_name = "app-najeeb-sandbox-aksadmin"
  }
}

azuread_service_principals = {
  aks_auth_app = {
    azuread_application = {
      key = "aks_auth_app"
    }
  }
}

managed_identities = {
  workload_system_mi = {
    name               = "demo-mi-wi"
    resource_group_key = "msi_region1"
  }
}
