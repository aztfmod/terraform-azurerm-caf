azuread_users = {
  user1 = {
    user_principal_name = "jdoe@terraformdev.onmicrosoft.com"
    display_name        = "J. Doe"
    mail_nickname       = "jdoe"
    password            = "SecretP@sswd99!"
  }
}
azuread_groups = {
  group1 = {
    display_name           = "group1"
    name                   = "group1"
    description            = "Apps with permissions"
    security_enabled       = true
  }
}
azuread_administrative_units = {
  admu1 = {
    display_name = "Example-AU"
    description  = "Just an example"
    visibility   = "Public"
  }
}
azuread_administrative_unit_members = {
  admum1 = {
    administrative_unit_object = {
      key = "admu1"
    }
    member_object = {
      obj_type = "azuread_users"
      key      = "user1"
    }
  }
  admum2 = {
    administrative_unit_object = {
      key = "admu1"
    }
    member_object = {
      obj_type = "azuread_groups"
      key      = "group1"
    }
  }
}