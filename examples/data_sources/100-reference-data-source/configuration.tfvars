global_settings = {
  default_region = "region1"
  regions = {
    region1       = "westus"
    australiaeast = "australiaeast"
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
