global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  random_length = 5
}

resource_groups = {
  test = {
    name = "test"
  }
}

keyvaults = {
  test_client = { #KeyVault Key
    name                = "testkv"
    resource_group_key  = "test"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

keyvault_access_policies_azuread_apps = {
  test_client = {
    test_client = { #KeyVault Key
      azuread_app_key    = "test_client"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}

# Complete list of Provider Operations : https://docs.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations

custom_role_definitions = {
  test_role = {
    name        = "test_role"
    useprefix   = true
    description = "custom permissions for the app"

    assignable_scopes = {
      subscriptions = [
        {
          # Providing an object_id as string
          id = "/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333"
        }
      ]
      resource_groups = [
        {
          # lz_key = ""  # If resource is on a remote landingzone
          key = "test"
        },
        {
          # Providing an object_id as string
          id = "/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup"
        }
      ]
    }

    permissions = {
      actions = [
        "Microsoft.KeyVault/vaults/delete",
        "Microsoft.KeyVault/vaults/read",
        "Microsoft.KeyVault/vaults/write",
        "Microsoft.KeyVault/vaults/accessPolicies/write",
        "Microsoft.Network/networkSecurityGroups/delete",
        "Microsoft.Network/networkSecurityGroups/read",
        "Microsoft.Network/networkSecurityGroups/write",
        "Microsoft.Network/networkSecurityGroups/join/action",
        "Microsoft.Network/virtualNetworks/subnets/delete",
        "Microsoft.Network/virtualNetworks/subnets/read",
        "Microsoft.Network/virtualNetworks/subnets/write",
        "Microsoft.OperationalInsights/workspaces/delete",
        "Microsoft.OperationalInsights/workspaces/read",
        "Microsoft.OperationalInsights/workspaces/write",
        "Microsoft.OperationalInsights/workspaces/sharedKeys/action",
        "Microsoft.OperationsManagement/solutions/delete",
        "Microsoft.OperationsManagement/solutions/read",
        "Microsoft.OperationsManagement/solutions/write",
        "Microsoft.Storage/storageAccounts/delete",
        "Microsoft.Storage/storageAccounts/read",
        "Microsoft.Storage/storageAccounts/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/delete",
        "Microsoft.Storage/storageAccounts/blobServices/containers/read",
        "Microsoft.Storage/storageAccounts/blobServices/containers/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/lease/action",
        "Microsoft.Storage/storageAccounts/blobServices/read",
        "Microsoft.Storage/storageAccounts/listKeys/action",
        "Microsoft.Resources/subscriptions/providers/read",
        "Microsoft.Resources/subscriptions/read",
        "Microsoft.Resources/subscriptions/resourcegroups/delete",
        "Microsoft.Resources/subscriptions/resourcegroups/read",
        "Microsoft.Resources/subscriptions/resourcegroups/write",
        "Microsoft.Network/virtualNetworks/delete",
        "Microsoft.Network/virtualNetworks/read",
        "Microsoft.Network/virtualNetworks/write",
      ]
    }
  }
}


azuread_apps = {
  test_client = {
    useprefix                    = true
    application_name             = "test_client"
    app_role_assignment_required = true
    keyvaults = {
      test_client = {
        secret_prefix = "test-client"
      }
    }
    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    # Set the policy during the creation process of the launchpad
  }
}

role_mapping = {
  custom_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "test_role" = {
          azuread_apps = {
            keys = ["test_client"]
          }
        }
      }
    }
  }

}

