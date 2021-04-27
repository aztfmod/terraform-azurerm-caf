global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

lighthouse_definitions = {
  lighthousedef1 = {
    name               = "CAF Maintainers - Reader"
    description        = "Provides Contributor role to the Group CAF Maintainers"
    managing_tenant_id = "3217d691-edcd-490d-b5ec-dc724087b782"  # The ID of the managing tenant
    managed_subscription_id = {
      key    = ""
      lz_key = "" # optional
      id     = "/subscriptions/06abbca2-ec1f-4a7f-9d2c-20355a1ffabe" # The ID of the managed subscription.
    }
    # Scope IDs to associate the Lighthouse definition (Subscription ID or Resource Group ID).
    scopes = {
      subscription = {
        key = ""
        lz_key = "" # optiona
        id  = "/subscriptions/06abbca2-ec1f-4a7f-9d2c-20355a1ffabe" #
      }
      resource_groups = {
        rg1 = {
          key    = "" 
          lz_key = "" # optional
          id     = "" # 
        },
        rg2 = {
          key    = ""
          lz_key = "" # optional
          id     = ""
        }
      }
    }
    # List of Authorization objects.
    authorizations = {
      auth1 = {
        principal_display_name = "CAF Maintainers (AAD Group)"
        built_in_role_name     = "Reader"
        #delegated_role_definitions = ["Reader", "test"]
        managed_identity = {
          key    = ""
          lz_key = "" # optional
          id     = ""
        }
        azuread_group = {
          key    = ""
          lz_key = "" # optional
          id     = "8833edce-0f1d-4948-ac11-161be573d7f7" # Group id eg: 8833edce-0f1d-4948-ac11-161be573d7f7
        }
        azuread_user = {
          key    = ""
          lz_key = "" # optional
          id     = ""
        }
        azuread_app = {
          key    = ""
          lz_key = "" # optional
          id     = ""
        }
      }
    }
  }
}