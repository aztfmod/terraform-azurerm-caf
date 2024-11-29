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

role_mapping = {
  built_in_role_mapping = {
    keyvaults = {
      kv1 = {
        "Key Vault Secrets User" = {
          azuread_groups = {
            "launchpad" = {           # lz_key as object key when you need to map same identity type from different lz
              keys = ["caf_platform_maintainers"]
            } 
            "identity_level2" = {     # lz_key as object key when you need to map same identity type from different lz
              keys = ["kv_admins"]
            }            
          }
        }
      }

    }
  }
}
