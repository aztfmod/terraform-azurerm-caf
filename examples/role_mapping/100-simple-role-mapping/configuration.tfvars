global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name = "example-msi-kv-rg1"
  }
}

keyvaults = {
  kv1 = {
    name                      = "kv1examplemsi"
    resource_group_key        = "rg1"
    sku_name                  = "premium"
    soft_delete_enabled       = true
    enable_rbac_authorization = true

    # creation_policies = {}
    # }

  }
}

managed_identities = {
  example_msi = {
    name               = "example-msi-kv-rolemap-msi"
    resource_group_key = "rg1"
  }
}

role_mapping = {
  built_in_role_mapping = {
    keyvaults = {
      kv1 = {
        # lz_key = "" to be defined when the keyvault is created in a different lz

        "Key Vault Secrets User" = {
          managed_identities = {
            # lz_key = "" to be defined when the msi is created in a different lz
            keys = ["example_msi"]
          }
        }
      }

    }
  }
}
