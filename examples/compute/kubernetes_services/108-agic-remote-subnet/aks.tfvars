aks_clusters = {
  cluster_re1 = {
    name               = "akscluster01"
    resource_group_key = "aks_re1"
    os_type            = "Linux"
    lz_key             = "networking"
    subnet_key         = "app01"

    identity = {
      type                 = "UserAssigned"
      managed_identity_key = "aks_usermsi"
    }

    kubernetes_version = "1.23.8" 

    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    network_profile = {
      network_plugin     = "azure"
      network_policy     = "azure"
      service_cidr       = "8.8.0.0/16"
      dns_service_ip     = "8.8.0.10"
      docker_bridge_cidr = "8.9.0.1/16"
    }

    private_cluster_enabled = true
    role_based_access_control = {
      enabled = true
      azure_active_directory = {
        managed = true
      }
    }

    default_node_pool = {
      name    = "aksnodes01"
      vm_size = "Standard_F4s_v2"
      subnet = {
        lz_key        = "networking"
        key           = "app01"
      }
      availability_zones           = ["1"]
      enabled_auto_scaling         = true
      enable_node_public_ip        = false
      max_pods                     = 30
      node_count                   = 2
      os_disk_size_gb              = 512
      # when using ingress_application_gateway you need an additional node_pool as agic is a non-critical addon
      only_critical_addons_enabled = false               
      orchestrator_version         = "1.23.8" 
    }

    node_resource_group_name = "aksnodesrg"
  

    addon_profile = {
      azure_policy = {
        enabled = true
      }
      # AGIC as an AKS add-on
      ingress_application_gateway = {
        enabled = true
        key     = "agw"
      }
    }
  }
}
