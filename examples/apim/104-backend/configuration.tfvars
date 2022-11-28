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

api_management_backend = {
  apimb1 = {
    name = "example-backend"
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    protocol = "http"
    url      = "https://backend"
  }
}