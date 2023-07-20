###############################################################################
# data_sources uses the same structure as remote_objects
# It is going to be merged into the local.combined_obects_<OBJECT_TYPE>
# using the `client_config.landingzone_key` as lz_key
###############################################################################
data_sources = {
  resource_groups = {
    my_rg = { # resource group key
      # must be in the default subscription set by ARM_SUBSCRIPTION_ID to avoid an error
      name     = "mlyt-rg-launchpad-level4"
      location = "australiaeast"
    }
  }
  subscriptions = {
    my_subscription = {
      # Must match the AZTFMOD output.tf attributes
      # https://github.com/aztfmod/terraform-azurerm-caf/blob/5183f651822eb56cf208c852ca8cb0581f31dc38/modules/subscriptions/output.tf
      id              = "/subscriptions/xxxxxxxx-818a-4b9f-8338-22368e098c5c"
      subscription_id = "xxxxxxxx-818a-4b9f-8338-22368e098c5c"
    }
  }
  azuread_groups = {
    existing = {
      # https://github.com/aztfmod/terraform-azurerm-caf/blob/06d281ed891f0ac8acf4583c8291b899a55117d5/modules/azuread/groups/output.tf
      id      = "xxxxxxxx-b449-419e-aad8-fd6bf6d1f306"
      rbac_id = "xxxxxxxx-b449-419e-aad8-fd6bf6d1f306" # When used in role mapping
    }
  }
  keyvaults = {
    existing_keyvault = {
      # must be in the default subscription set by ARM_SUBSCRIPTION_ID to avoid an error
      # https://github.com/hashicorp/terraform-provider-azurerm/issues/22064
      id   = "/subscriptions/xxxxxxxx-b8a5-407a-9e69-1ed0ff53d8b0/resourceGroups/j20-rg-launchpad-level4/providers/Microsoft.KeyVault/vaults/j20-kv-level4"
      name = "j20-kv-level4"
    }
  }
  vnets = {
    vnet_existing = {
      id = "/subscriptions/xxxxxxxx-aba1-47ff-b620-1d01350e2dd5/resourceGroups/mlyt-rg-launchpad-level4/providers/Microsoft.Network/virtualNetworks/vnet-existing"
      subnets = {
        default = {
          id = "/subscriptions/xxxxxxxx-aba1-47ff-b620-1d01350e2dd5/resourceGroups/mlyt-rg-launchpad-level4/providers/Microsoft.Network/virtualNetworks/vnet-existing/subnets/default"
        }
        apps = {
          id = "/subscriptions/xxxxxxxx-aba1-47ff-b620-1d01350e2dd5/resourceGroups/mlyt-rg-launchpad-level4/providers/Microsoft.Network/virtualNetworks/vnet-existing/subnets/apps"
        }
        private_endpoints = {
          id = "/subscriptions/xxxxxxxx-aba1-47ff-b620-1d01350e2dd5/resourceGroups/mlyt-rg-launchpad-level4/providers/Microsoft.Network/virtualNetworks/vnet-existing/subnets/private-endpoints"
        }
      }
    }
  }
  # virtual_subnets = {
  #   default = {
  #     # Must be in the same region and subscription as the vm?
  #     id = "/subscriptions/xxxxxxxx-aba1-47ff-b620-1d01350e2dd5/resourceGroups/mlyt-rg-launchpad-level4/providers/Microsoft.Network/virtualNetworks/vnet-existing/subnets/default"
  #   }
  # }
  recovery_vaults = {
    existing_recovery_vault = { # virtual_machines[key].backup.vault_key
      # must be in the default subscription set by ARM_SUBSCRIPTION_ID to avoid an error
      name                = "existing-arsv"
      resource_group_name = "mlyt-rg-launchpad-level4"
      backup_policies = {
        virtual_machines = {
          DefaultPolicy = { # virtual_machines[key].backup.policy_key
            id = "/subscriptions/xxxxxxxx-aba1-47ff-b620-1d01350e2dd5/resourceGroups/mlyt-rg-launchpad-level4/providers/Microsoft.RecoveryServices/vaults/existing-arsv/backupPolicies/DefaultPolicy"
          }
        }
      }
    }
  }
  storage_accounts = {
    sa1 = {
      resource_group_name = "mlyt-rg-launchpad-level4"
      name                = "mlytstlevel4"
    }
  }
}
