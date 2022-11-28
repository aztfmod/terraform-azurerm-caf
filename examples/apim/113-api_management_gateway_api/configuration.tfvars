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

api_management_gateway = {
  apimgw1 = {
    name = "example-gateway"
    api_management = {
      key = "apim1"
      #lz_key = ""
      #name = ""
    }
    description = "Example API Management gateway"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }

    location_data = {
      name     = "example name"
      city     = "example city"
      district = "example district"
      region   = "example region"
    }
  }
}

api_management_gateway_api = {
  apimgwapi1 = {
    api_management_gateway = {
      key = "apimgw1"
      #lz_key = ""
      #id = ""
    }
    api_management_api = {
      key = "apima1"
      #lz_key = ""
      #id = ""
    }
  }
}