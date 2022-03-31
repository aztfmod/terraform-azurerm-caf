global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
  random_length = 5
}

resource_groups = {
  test = {
    name = "test"
  }
}

keyvaults = {
  test_kv = {
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

azuread_applications = {
  app1 = {
    display_name                 = "app1"
    useprefix                    = true
    application_name             = "app1"
    app_role_assignment_required = true
    keyvaults = {
      test_kv = {
        secret_prefix = "app1"
      }
    }
  }
  app2 = {
    display_name                 = "app2"
    useprefix                    = true
    application_name             = "app2"
    app_role_assignment_required = true
    keyvaults = {
      test_kv = {
        secret_prefix = "app2"
      }
    }
  }
}

azuread_groups = {
  group1 = {
    display_name           = "group1"
    name                   = "group1"
    description            = "Apps with permissions"
    members                = []
    owners                 = []
    prevent_duplicate_name = false
    security_enabled       = true
  }

}
azuread_groups_membership = {
  memb1 = {
    group_object = {
      key = "group1"
      #id = "UUID"
    }
    member_object = {
      obj_type = "azuread_applications"
      key      = "app1"
    }
  }
}
role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      # subcription level access
      logged_in_subscription = {
        "Contributor" = {
          azuread_groups = {
            keys = ["group1"]
          }
        }
      }
    }
  }
}