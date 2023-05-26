global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

###############################################################################
# data_sources uses the same structure as remote_objects
# It is going to be merged into the local.combined_obects_<OBJECT_TYPE>
# using the `client_config.landingzone_key` as lz_key
###############################################################################
data_sources = {
  subscriptions = {
    my_subscription = { # data source key
      subscription_id = "11111111-1111-1111-1111-111111111111"
    }
  }
}

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "Contributor" = {
          managed_identities = {
            keys = ["my_msi"]
          }
        }
      }

      my_subscription = { # data source key
        "Contributor" = {
          managed_identities = {
            keys = ["my_msi"]
          }
        }
      }
    }
  }
}