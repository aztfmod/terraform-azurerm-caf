# User assigned identities
managed_identities = {
  rover = {
    name               = "rover"
    resource_group_key = "rg1"
  }
}

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      # subcription level access
      logged_in_subscription = {
        "Contributor" = {
          managed_identities = {
            keys = ["rover"]
          }
        }
        "Owner" = {
          managed_identities = {
            keys = ["rover"]
          }
        }
      }
    }
  }
}