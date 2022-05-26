global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  random_length = 5
}

resource_groups = {
  rg1 = {
    name = "example-msi-rg"
  }
}


managed_identities = {
  msi1 = {
    name               = "example-msi1"
    resource_group_key = "rg1"
  }
}

azuread_groups = {
  ad_group1 = {
    name        = "example-group1"
    description = "Provide read and write access"
    members = {
      user_principal_names = []
      group_names          = []
      object_ids           = []
      group_keys           = []

      service_principal_keys = []

    }
    owners = {
      user_principal_names = []
    }
    prevent_duplicate_name = false
  }
}


azuread_groups_membership = {
  ad_group1 = { # ad group key
    managed_identities = {
      launchpad = {
        # group_lz_key = "" # group lz_key
        # lz_key = ""       # managed_identity lz_key
        keys = ["msi1"]
      }
    }
  }
  # ad_group2 = { # ad group key
  #   # group_lz_key = "" # group lz_key
  #   members = {
  #     azuread_service_principal_keys = ["spkey"] # add service principal to group
  #   }
  # }
}
