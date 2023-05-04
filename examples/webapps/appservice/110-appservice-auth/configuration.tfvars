global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  webapp_simple = {
    name   = "webapp-simple"
    region = "region1"
  }
}

azuread_applications = {
  test_client = {
    useprefix        = true
    application_name = "test-client"
    reply_urls       = ["https://example.azurewebsites.net/.auth/login/aad/callback"]
  }
}

azuread_service_principals = {
  sp1 = {
    azuread_application = {
      key = "test_client"
    }
    app_role_assignment_required = true
  }
}

azuread_service_principal_passwords = {
  sp1 = {
    azuread_service_principal = {
      key = "sp1"
    }
    password_policy = {
      length         = 250
      special        = false
      upper          = true
      number         = true
      expire_in_days = 10
      rotation = {
        mins = 3
      }
    }
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "webapp_simple"
    name               = "asp-simple"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "webapp_simple"
    name                 = "webapp-simple"
    app_service_plan_key = "asp1"

    app_settings = {
      "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
    }

    settings = {
      enabled = true

      auth_settings = {
        enabled                       = true
        unauthenticated_client_action = "RedirectToLoginPage"
        issuer                        = "https://login.microsoftonline.com/00000000-0000-0000-0000-000000000000"
        active_directory = {
          client_id_key     = "test_client"
          client_secret_key = "sp1"
        }
      }
    }
  }
}
