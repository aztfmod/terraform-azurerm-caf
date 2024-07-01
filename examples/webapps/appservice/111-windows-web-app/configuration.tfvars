global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    env = "to_be_set"
  }
}

resource_groups = {
  windows_webapp_simple = {
    name   = "windows-webapp-simple"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "windows_webapp_simple"
    name               = "asp-simple"

    sku = {
      tier = "Standard"
      size = "S1"
    }
    tags = {
      env = "uat"
    }
  }
}

windows_web_apps = {
 windows_web_app_simple = {
    name                 = "windows-web-app-simple"
    resource_group_key   = "windows_webapp_simple"
    app_service_plan_key = "asp1"

    settings = {
      https_only = "true"
      always_on  = "false"

      site_config = {
        ftps_state      = "Disabled"
        always_on       = "false"
        
        application_stack = {
          current_stack = "dotnetcore"
          dotnet_core_version = "v4.0"
        }
      }
    }
    app_settings = {
      example_setting = "example-setting"
    }
  }
}