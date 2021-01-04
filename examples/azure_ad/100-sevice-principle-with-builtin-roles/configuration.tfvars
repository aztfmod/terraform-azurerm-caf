global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  test = {  #resource_group_key
    name = "test"
  }
}

keyvaults = {
  test_client = {
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
  test_client  = {
    test_client = {
      azuread_app_key    = "test_client"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}

azuread_apps = {
  test_client = {
    useprefix                    = true
    application_name             = "test-client"
    password_expire_in_days      = 1
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

#complete list of built-in-roles : https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      # subcription level access
      logged_in_subscription = {
        "Contributor" = {
          azuread_apps = {
            keys = ["test_client"]
           }
        }
      }
    }
  }
}

azuread_roles = {
  packer_client = {
    roles = [
      "Contributor"
    ]
  }
}

