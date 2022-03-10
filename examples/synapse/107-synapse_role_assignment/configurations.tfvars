
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}
storage_accounts = {
  sa1 = {
    name                     = "sa1"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
storage_data_lake_gen2_filesystem = {
  sdlg21 = {
    name = "example"
    storage_account = {
      key = "sa1"
    }
  }
}

synapse_workspace = {
  syws1 = {
    name = "example"
    resource_group = {
      key = "rg1"
    }
    location = "region1"
    storage_data_lake_gen2_filesystem = {
      key = "sdlg21"
    }
    sql_administrator_login          = "sqladminuser"
    sql_administrator_login_password = "H@Sh1CoR3!"
    tags = {
      Env = "production"
    }
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

azuread_users = {
  user1 = {
    user_name    = "demo-user"
    keyvault_key = "test_client"
    password_policy = {
      length  = 250
      special = false
      upper   = true
      number  = true

      expire_in_days = 10
      rotation = {
        mins = 1 # only recommended for CI and demo
      }
    }
  }
}
synapse_role_assignment = {
  syra1 = {
    synapse_workspace = {
      key = "syws1"
    }
    role_name = "Synapse SQL Administrator"
    principal = {
      #id  = ""
      type = "azuread_users"
      key  = "user1"
    }
  }
}