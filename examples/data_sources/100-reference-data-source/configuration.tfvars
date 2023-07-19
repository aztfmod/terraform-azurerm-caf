global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

###############################################################################
# data_sources uses the same structure as remote_objects
# It is going to be merged into the local.combined_obects_<OBJECT_TYPE>
# using the `client_config.landingzone_key` as lz_key
###############################################################################
data_sources = {
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
      id = "/subscriptions/xxxxxxxx-b8a5-407a-9e69-1ed0ff53d8b0/resourceGroups/j20-rg-launchpad-level4/providers/Microsoft.KeyVault/vaults/j20-kv-level4"
    }
  }
}

resource_groups = {
  my_rg = { # resource group key
    name = "my_rg"
  }
}

managed_identities = {
  my_msi = { # managed identity key
    name               = "my_msi"
    resource_group_key = "my_rg"
  }
}

azuread_groups = {
  my_group = { # azuread group key
    name = "my_group"
  }
}

azuread_groups_membership = {
  existing = { # azuread group key
    azuread_groups = {
      members = {
        keys = ["my_group"]
      }
    }
    managed_identities = {
      members = {
        keys = ["my_msi"]
      }
    }
  }
}

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "Contributor" = {
          managed_identities = {
            keys = ["my_msi"]
          }
        }
      }

      my_subscription = { # data source key
        "Contributor" = {
          azuread_groups = {
            keys = ["existing"]
          }
        }
      }
    }
    keyvaults = {
      existing_keyvault = {
        "Key Vault Secrets User" = {
          azuread_groups = {
            keys = ["existing"]
          }
        }
      }
    }
  }
}