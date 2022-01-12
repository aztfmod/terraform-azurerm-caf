global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}


api_management = {
  apim1 = {
    name   = "example-apim"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    publisher_name  = "My Company"
    publisher_email = "company@terraform.io"

    sku_name = "Developer_1"
  }
}

keyvaults = {
  test_client = {
    name                = "testkv"
    resource_group_key  = "rg1"
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
      azuread_app_key    = "test_client"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}
azuread_users = {
  user1 = {
    user_name    = "demo-user"
    keyvault_key = "test_client"
    password_policy = {
      # Length of the password
      length  = 250
      special = false
      upper   = true
      number  = true

      expire_in_days = 10
      rotation = {
        mins = 1 # only recommended for CI and demo
      }
    } //password_policy
  }
}
api_management_user = {
  apimu1 = {
    user = {
      key = "user1"
      id  = "1234567890"
    }
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    first_name = "Example"
    last_name  = "User"
    email      = "tom+tfdev@hashicorp.com"
    state      = "active"
  }
}