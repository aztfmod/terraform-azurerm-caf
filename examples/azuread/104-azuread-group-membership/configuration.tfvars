global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
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
}