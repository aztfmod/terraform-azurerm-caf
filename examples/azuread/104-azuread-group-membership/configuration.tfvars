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
    display_name     = "test"
    security_enabled = true
    name             = "example-group1"
    description      = "Provide read and write access"
    # Do not use nested blocks for the members, use azuread_groups_membership as exhibited below
    # members                = []
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
  # ad_group2 = { # ad group key
  #   # group_lz_key = "" # group lz_key
  #   members = {
  #     azuread_service_principal_keys = ["spkey"] # add service principal to group
  #   }
  # }
}
