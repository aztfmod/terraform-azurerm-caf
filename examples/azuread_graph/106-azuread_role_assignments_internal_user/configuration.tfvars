azuread_applications = {
  app1 = {
    display_name = "example"
    app_role = {
      allowed_member_types = ["Application", "User"]
      description          = "Admins can perform all task actions"
      display_name         = "Admin"
      enabled              = true
      id                   = "00000000-0000-0000-0000-222222222222"
      value                = "Admin.All"
    }
  }
}
azuread_service_principals = {
  sp1 = {
    application = {
      key = "app1"
    }
  }
}
azuread_groups = {
  group1 = {
    display_name     = "group1"
    security_enabled = true
  }
}
azuread_users = {
  user1 = {
    display_name        = "D. Duck"
    password            = "SecretP@sswd99!"
    user_principal_name = "d.duck@dione.solutions"
  }
}
azuread_app_role_assignments = {
  appra1 = {
    app_role = {
      key      = "sp1"
      role     = "Admin.All"
      obj_type = "azuread_service_principals"
    }
    principal_object = {
      obj_type = "azuread_groups"
      key      = "group1"
    }
    resource_object = {
      obj_type = "azuread_service_principals"
      key      = "sp1"
    }
  }
  appra1 = {
    app_role = {
      key      = "sp1"
      role     = "Admin.All"
      obj_type = "azuread_service_principals"
    }
    principal_object = {
      obj_type = "azuread_users"
      key      = "user1"
    }
    resource_object = {
      obj_type = "azuread_service_principals"
      key      = "sp1"
    }
  }
}