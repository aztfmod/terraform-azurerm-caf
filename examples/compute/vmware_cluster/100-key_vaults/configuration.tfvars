global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

resource_groups = {
  rgvwc = {
    name   = "vmwarecluster-test"
    region = "region1"
  }
}

keyvaults = {
  kv_rg1 = {
    name               = "kv1"
    resource_group_key = "rgvwc"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

dynamic_keyvault_secrets = {
  kv_rg1 = { # Key of the keyvault
    secret_key1 = {
      secret_name = "nsxt-password"
      value       = ""
    }
    secret_key2 = {
      secret_name = "vcenter-password"
      value       = ""
    }
  }
}