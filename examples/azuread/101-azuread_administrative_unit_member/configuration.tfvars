#
# Do not use the administrative_unit_ids / administrative_units property at the same time as the azuread_administrative_unit_members resource,
# or the members property of the azuread_administrative_unit resource, for the same group.
# Doing so will cause a conflict and administrative unit members will be removed.
#

azuread_groups = {
  group1 = {
    display_name     = "group1"
    description      = "Apps with permissions"
    security_enabled = true
  }
  group2 = {
    display_name     = "group2"
    description      = "Group only created in Azure administrative unit"
    security_enabled = true
    administrative_units = {
      admu1 = {
        key = "admu1"
      }
    }
  }
  group3 = {
    display_name     = "group3"
    description      = "Group only created in existing Azure administrative unit"
    security_enabled = true
    administrative_units = {
      admu1 = {
        id = "a4f6b07c-cca0-4442-ba6f-6f8321f8ccc2"
      }
    }
  }
}
azuread_administrative_units = {
  admu1 = {
    display_name              = "Example-AU"
    description               = "Just an example"
    hidden_membership_enabled = false
  }
}

azuread_administrative_unit_members = {
  # Add an Azure AD Group from tenant root into the administrative unit
  admum2 = {
    administrative_unit_object = {
      key = "admu1"
    }
    member_object = {
      resource_type = "azuread_groups"
      key           = "group1"
    }
  }
}