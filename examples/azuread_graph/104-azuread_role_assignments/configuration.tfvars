azuread_applications = {
  app1 = {
    display_name = "example"
    required_resource_access = {
      resource_app = {
        well_known_key = "MicrosoftGraph"
      }
      resource_access = {
        id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
        type = "Role"
      }
    }
  }
}

azuread_service_principals = {
  sp1 = {
    application = {
      well_known_key = "MicrosoftGraph"
    }
    use_existing = true
  }
  sp2 = {
    application = {
      key = "app1"
    }
  }
}

azuread_app_role_assignments = {
  appra1 = {
    app_role = {
      #obj_type = "AppRole"
      key          = "sp1"
      role         = "User.Read.All"
      app_role_key = "MicrosoftGraph"
      obj_type     = "azuread_service_principals"
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
