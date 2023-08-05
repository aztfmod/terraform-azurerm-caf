global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = "true"
}

resource_groups = {
  test = {
    name = "rg-maps-test"
  }
}

maps_accounts = {
  map1 = {
    name = "map1"
    resource_group = {
      key = "test"
    }
    sku_name = "S1"
    tags = {
      environment = "test"
    }
    keyvault = {
      key = "kv_maps"
    }
  }
  map2 = {
    name = "map2"
    resource_group = {
      key = "test"
    }
    sku_name = "S0"
    tags = {
      environment = "test"
    }
    keyvault = {
      key = "kv_maps"
    }
  }
}

keyvaults = {
  kv_maps = {
    name                = "kv_maps"
    resource_group_key  = "test"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

