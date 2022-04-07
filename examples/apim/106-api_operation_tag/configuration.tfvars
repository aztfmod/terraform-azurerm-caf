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
    publisher_name  = "My Company"
    publisher_email = "company@terraform.io"

    sku_name = "Developer_1"
  }
}

api_management_api = {
  apimapi1 = {
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



api_management_api_operation = {
  apimapio1 = {
    operation_id = "sample"
    api = {
      key = "apimapi1"
    }
    api_management = {
      key = "apim1"
    }
    resource_group = {
      key = "rg1"
    }

    display_name = "Get WishLists"
    method       = "GET"
    url_template = "/wishlists"
    description  = "Get WishList"
    request = {
      query_parameter = {
        name     = "test"
        required = false
        type     = "string"
        values   = ["true", "false"]
      }
    }
  }
}

api_management_api_operation_tag = {
  apimapiot1 = {
    api_operation = {
      key = "apimapio1"
    }
    name         = "example-Tag"
    display_name = "display-name"
  }
}