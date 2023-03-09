keyvaults = {
  test_client = {
    name                = "testkv"
    resource_group_key  = "aro1"
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
    application_name = "aro-test"
  }
}


azuread_service_principals = {
  sp1 = {
    azuread_application = {
      key = "test_client"
    }

    # app_role_assignment_required = true
    tags = [
      "AzureRedHatOpenShift"
    ]
  }
}

azuread_credential_policies = {
  default_policy = {
    # Length of the password
    length  = 250
    special = false
    upper   = true
    number  = true
    # Password Expiration date
    expire_in_days = 90
    rotation_key0 = {
      # Odd number
      days = 33
    }
    rotation_key1 = {
      # Even number
      days = 58
    }
  }
}

azuread_credentials = {
  test1 = {
    type                          = "password"
    azuread_credential_policy_key = "default_policy"
    azuread_application = {
      key = "test_client"
    }
    keyvaults = {
      test_client = {
        secret_prefix = "test-client"
      }
    }
  }
}

#complete list of built-in-roles : https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles

role_mapping = {
  built_in_role_mapping = {
    networking = {
      # subcription level access
      vnet1 = {
        "Contributor" = {
          azuread_service_principals = {
            keys = ["sp1"]
          }
          object_ids = {
            keys = ["004c3094-aa2e-47f3-87aa-f82a155ada54"]
            // To get the value for your tenant use the following coommand:
            // az ad sp list --display-name "Azure Red Hat OpenShift RP" --query "[0].id" -o tsv
            // Todo get object ID from ARO RP ID
            // add capability to specify SP by name: azuread_service_principal_names = {
            // # keys = []
            // cond data source to crack the names to GUID
            //}
          }
        }
      }
    }

  }
}

