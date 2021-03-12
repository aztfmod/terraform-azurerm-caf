azuread_roles = {
  packer_client = {
    roles = [
      "Contributor"
    ]
  }
}

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "Contributor" = {
          azuread_apps = {
            keys   = ["packer_client"]
            lz_key = "examples"
          }
        }
      }
    }
  }
}