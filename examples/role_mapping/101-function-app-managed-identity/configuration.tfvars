regions = {
  region1 = "uksouth"
  region2 = "northeurope"
}

resource_groups = {
  rg = {
    name   = "example-rg"
    region = "region1"
  }
}

storage_accounts = {
  stg = {
    name                     = "examplestg"
    resource_group_key       = "rg"
    region                   = "region1"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

app_service_plans = {
  asp = {
    name               = "asp-example"
    resource_group_key = "rg"
    region             = "region1"
    kind               = "functionapp"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

function_apps = {
  app = {
    name               = "app-example"
    resource_group_key = "rg"

    region               = "region1"
    app_service_plan_key = "asp"
    storage_account_key  = "stg"
    settings = {
      version = "~4"
    }

    identity = {
      type = "SystemAssigned"
    }
  }
}

keyvaults = {
  kv = {
    name               = "example-kv"
    sku_name           = "standard"
    resource_group_key = "rg"

    enable_rbac_authorization = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}



role_mapping = {
  built_in_role_mapping = {

    keyvaults = {
      kv = {
        "Key Vault Certificates Officer" = {
          function_apps = {
            keys = ["app"]
          }
        }
      }
    }
  }
}
