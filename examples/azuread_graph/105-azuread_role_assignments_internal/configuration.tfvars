azuread_applications = {
  app1 = {
    display_name = "example"
    app_role = {
      allowed_member_types = ["Application"]
      description          = "Apps can query the database"
      display_name         = "Query"
      enabled              = true
      id                   = "00000000-0000-0000-0000-111111111111"
      value                = "Query.All"
    }
  }
  app2 = {
    display_name = "example"
  }
}
azuread_service_principals = {
  sp1 = {
    application = {
      key = "app1"
    }
  }
  sp2 = {
    application = {
      key = "app2"
    }
  }
}
azuread_app_role_assignments = {
  appra1 = {
    app_role = {
      key      = "sp1"
      role     = "Query.All"
      obj_type = "azuread_service_principals"
    }
    principal_object = {
      obj_type = "azuread_service_principals"
      key      = "sp2"
    }
    resource_object = {
      obj_type = "azuread_service_principals"
      key      = "sp1"
    }
  }
}