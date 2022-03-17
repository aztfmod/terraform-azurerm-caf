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

api_management_group = {
  apimg1 = {

    name = "example-apimg"
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    display_name = "Example Group"
    description  = "This is an example API management group."
  }
}