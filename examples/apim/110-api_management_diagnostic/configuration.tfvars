global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}


api_management = {
  apim1 = {
    name   = "example-apim"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    publisher_name  = "My Company"
    publisher_email = "company@terraform.io"

    sku_name = "Developer_1"
  }
}
azurerm_application_insights = {
  webappi1 = {
    name               = "tf-test-appinsights-web"
    resource_group_key = "rg1"
    application_type   = "web"
  }
}
api_management_logger = {
  apiml1 = {
    name = "example-logger"
    api_management = {
      key = "apim1"
    }
    resource_group = {
      key = "rg1"
    }
    resource = {
      key = "webappi1"
    }
    application_insights = {
      key = "webappi1"
    }
  }
}
api_management_diagnostic = {
  apimd1 = {
    identifier = "applicationinsights"
    api_management = {
      key = "apim1"
    }
    resource_group = {
      key = "rg1"
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