global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

lighthouse_definitions = {
  lighthousedef1 = {
    name               = "CAF Maintainers - Reader"
    description        = "Provides Contributor role to the Group CAF Maintainers"
    managing_tenant_id = "5332f9b1-12d5-4e12-b10f-b99132616023" # The ID of the managing tenant
    managed_subscription_id = {
      key    = ""
      lz_key = ""                                                    # optional
      id     = "/subscriptions/ede4d758-a1da-4031-b27f-2752d719d820" # The ID of the managed subscription.
    }
    # Scope IDs to associate the Lighthouse definition (Subscription ID or Resource Group ID).
    scopes = {
      subscription = {
        key    = ""
        lz_key = "" # optional
        id     = "/subscriptions/ede4d758-a1da-4031-b27f-2752d719d820"
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
          id     = ""
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