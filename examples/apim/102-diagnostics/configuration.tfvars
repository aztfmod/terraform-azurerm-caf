global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}
azurerm_application_insights = {
  ai1 = {
    name               = "test-appinsights-apim"
    resource_group_key = "rg1"
    application_type   = "web"
  }
}
api_management = {
  apim1 = {
    name   = "example-apim"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    publisher_name  = "My Company"
    publisher_email = "company@terraform.io"

    sku_name = "Developer_1"
  }
}
api_management_api = {
  apima1 = {
    name = "example-api"
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    revision     = "1"
    display_name = "Example API"
    path         = "example"
    protocols    = ["https"]

    import = {
      content_format = "swagger-link-json"
      content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
    }
  }
}


api_management_logger = {
  apiml1 = {
    name = "example-apimlogger"
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }

    application_insights = {
      key = "ai1"
    }
  }
}

api_management_api_diagnostic = {
  apimd1 = {
    identifier = "applicationinsights"
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    api = {
      key = "apima1"
    }
    api_management_logger = {
      key = "apiml1"
    }

    sampling_percentage       = 5.0
    always_log_errors         = true
    log_client_ip             = true
    verbosity                 = "verbose"
    http_correlation_protocol = "W3C"

    frontend_request = {
      body_bytes = 32
      headers_to_log = [
        "content-type",
        "accept",
        "origin",
      ]
    }

    frontend_response = {
      body_bytes = 32
      headers_to_log = [
        "content-type",
        "content-length",
        "origin",
      ]
    }

    backend_request = {
      body_bytes = 32
      headers_to_log = [
        "content-type",
        "accept",
        "origin",
      ]
    }

    backend_response = {
      body_bytes = 32
      headers_to_log = [
        "content-type",
        "content-length",
        "origin",
      ]
    }
  }
}