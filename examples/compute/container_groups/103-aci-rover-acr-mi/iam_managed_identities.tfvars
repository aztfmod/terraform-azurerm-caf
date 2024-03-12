managed_identities = {
  level0 = {
    name               = "id-level0"
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
            keys = ["level0"]
          }
        }
        "Owner" = {
          managed_identities = {
            keys = ["level0"]
          }
        }
      }
    }
  }
}