global_settings = {
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}
resource_groups = {
  rg1 = {
    name = "rg1"
  }
}

purview_accounts = {
  pva1 = {
    name   = "pva1"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
  }
}

keyvaults = {
  kv = {
    name                      = "kv"
    resource_group_key        = "rg1"
    sku_name                  = "standard"
    enable_rbac_authorization = true
    soft_delete_enabled       = true
    purge_protection_enabled  = true
    tags = {
      env = "Standalone"
    }
  }
}


role_mapping = {
  built_in_role_mapping = {
    keyvaults = {
      kv = {
        "Key Vault Administrator" = {
          purview_accounts = {
            keys = ["pva1"]
          }
        }
      }
    }
  }
}