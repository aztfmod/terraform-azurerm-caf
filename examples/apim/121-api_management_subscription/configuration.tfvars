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

api_management_product = {
  apimprod1 = {
    resource_group = {
      key = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    name                  = "example-product"
    subscription_required = true
    approval_required     = false
    published             = true
    display_name          = "Example PRODUCT"
  }
}

api_management_subscription = {
  apimsubscr1 = {
    display_name = "Example-Product-Subscription"
    resource_group = {
      key    = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    api_management_product = {
      key = "apimprod1"
    }
    primary_key   = "key-hash-1"
    secondary_key = "key-hash-2"

  }

  apimsubscr2 = {
    display_name = "Example-Api-Subscription"
    resource_group = {
      key    = "rg1"
    }
    api_management = {
      key = "apim1"
    }
    api_management_api = {
      key = "apimapi1"
    }
    api_management_user= {
      key = "apimu1"
    }
  }
}
