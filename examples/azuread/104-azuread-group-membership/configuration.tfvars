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
    display_name           = "test"
    security_enabled       = true
    name                   = "example-group1"
    description            = "Provide read and write access"
    members                = []
    owners                 = []
    prevent_duplicate_name = false
  }
}
azuread_groups_membership = {
  memb1 = {
    group_object = {
      key = "ad_group1"
      #id = "UUID"
    }
    member_object = {
      obj_type = "managed_identities"
      key      = "msi1"
    }
  }
}