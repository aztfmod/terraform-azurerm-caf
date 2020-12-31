resource_groups = {
  test = {
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

azuread_users = {
  user1 = {
    user_name    = "user1"
    keyvault_key = "test_client"
    secret_prefix = "test"
    useprefix     = true

  }
}

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      # subcription level access
      logged_in_subscription = {
        "Contributor" = {
          azuread_groups = {
            keys = ["user1"]
           }
        }
      }
    }
  }
}