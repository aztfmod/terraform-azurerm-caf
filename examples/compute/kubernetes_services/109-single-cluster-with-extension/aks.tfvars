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

    # oms_agent = {
    #   log_analytics_key = "central_logs_region1"
    # }

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

    cluster_extension = {
      backup = {
        name = "backup"
        extension_type = "microsoft.dataprotection.kubernetes"
        release_train  = "stable"
      
      configuration_settings = {
          "credentials.tenantId"                                      = "<tenant_id>"
          "configuration.backupStorageLocation.config.subscriptionId" = "<subscription_id>"
          "configuration.backupStorageLocation.config.resourceGroup"  = "aks-re1"
          "configuration.backupStorageLocation.config.storageAccount" = "sa1"
          "configuration.backupStorageLocation.bucket"                = "files"
        }
      }
    }
  }
}

storage_accounts = {
  sa1 = {
    name               = "sa1"
    resource_group_key = "aks_re1"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    #account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    containers = {
      files = {
        name = "files"
      }
    }
  }
}