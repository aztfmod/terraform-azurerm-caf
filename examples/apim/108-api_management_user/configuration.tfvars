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
api_management_user = {
  apimu1 = {
    user_id = "5931a75ae4bbd512288c680b"
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    first_name = "Example"
    last_name  = "User"
    email      = "tom+tfdev@hashicorp.com"
    state      = "active"
  }
}