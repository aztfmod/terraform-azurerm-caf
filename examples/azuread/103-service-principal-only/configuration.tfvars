global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  random_length = 5
}

resource_groups = {
  test = { #resource_group_key
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
  test_client = {
    test_client = {
      azuread_application_key = "test_client"
      secret_permissions      = ["Set", "Get", "List", "Delete"]
    }
  }
}


azuread_applications = {
  test_client = {
    useprefix        = true
    application_name = "test-client"
  }
}


azuread_service_principals = {
  sp1 = {
    azuread_application = {
      key = "test_client"
    }
    app_role_assignment_required = true
  }
}

azuread_service_principal_passwords = {
  sp1 = {
    azuread_service_principal = {
      key = "sp1"
    }
    password_policy = {
      # Length of the password
      length  = 250
      special = false
      upper   = true
      number  = true

      # Define the number of days the password is valid. It must be more than the rotation frequency
      expire_in_days = 10
      rotation = {
        #
        # Set how often the password must be rotated. When passed the renewal time, running the terraform plan / apply will change to a new password
        # Only set one of the value
        #

        mins = 3 # only recommended for CI and demo
        # days = 7
        # months = 1
      }
    }
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
          azuread_service_principals = {
            keys = ["sp1"]
          }
        }
      }
    }
  }
}

