azuread_users = {
  user1 = {
    user_principal_name = "jdoe@dione.solutions"
    display_name        = "J. Doe"
    mail_nickname       = "jdoe"
    password            = "SecretP@sswd99!"
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
}