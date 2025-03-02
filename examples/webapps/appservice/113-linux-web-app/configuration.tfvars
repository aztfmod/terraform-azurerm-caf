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
  linux_webapp_simple = {
    name   = "linux-webapp-simple"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "linux_webapp_simple"
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

linux_web_apps = {
  linux_web_app_simple = {
    name                 = "linux-web-app-simple"
    resource_group_key   = "linux_webapp_simple"
    app_service_plan_key = "asp1"

    settings = {
      https_only = "true"
      always_on  = "false"

      site_config = {
        ftps_state = "Disabled"
        always_on  = "false"

        application_stack = {
          java_server  = "JAVA"
          java_version = "11"
        }
      }
    }
    app_settings = {
      example_setting = "example-setting"
    }
  }
}