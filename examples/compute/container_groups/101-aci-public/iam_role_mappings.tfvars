role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "Contributor" = {
          managed_identities = {
            keys = ["rover_tfc"]
          }
        }
      }
    }
  }
}