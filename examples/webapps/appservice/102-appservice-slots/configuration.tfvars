global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  webapp_region1 = {
    name   = "webapp-rg"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "webapp_region1"
    name               = "asp1"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "webapp_region1"
    name                 = "webapp"
    app_service_plan_key = "asp1"

    settings = {
      enabled = true

      site_config = {
        default_documents        = ["main.aspx"]
        always_on                = true
        dotnet_framework_version = "v4.0"
      }
    }

    slots = {
      smoke_test = {
        name = "smoke-test"
      }
      ab_test = {
        name = "AB-testing"
      }
    }

    tags = {
      example = "simple_webapp"
    }
  }
}