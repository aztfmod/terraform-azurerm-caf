global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}


resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
  aks_jumpbox_re1 = {
    name = "aks-jumpbox-re1"
  }

}

storage_accounts = {
  bootdiag_re1 = {
    name                     = "bootdiag"
    resource_group_key       = "aks_jumpbox_re1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}


#
# IAM
#

managed_identities = {
  jumpbox = {
    name               = "aks-jumpbox"
    resource_group_key = "aks_jumpbox_re1"
  }
}

# azuread_groups = {
#   aks_admins = {
#     name        = "aks-admins"
#     description = "Provide access to the AKS cluster and the jumpbox Keyvault secret."
#     members = {
#       user_principal_names = [
#       ]
#       group_names = []
#       object_ids  = []
#       group_keys  = []

#       service_principal_keys = [
#       ]
#     }
#     prevent_duplicate_name = false
#   }
# }


#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#
role_mapping = {
  custom_role_mapping = {}

  built_in_role_mapping = {
    aks_clusters = {
      cluster_re1 = {
        "Azure Kubernetes Service Cluster Admin Role" = {
          # azuread_groups = {
          #   keys = ["aks_admins"]
          # }
          logged_in = {
            keys = ["user"]
          }
          managed_identities = {
            keys = ["jumpbox"]
          }
        }
      }
    }
    azure_container_registries = {
      acr1 = {
        "AcrPull" = {
          aks_clusters = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
  }
}