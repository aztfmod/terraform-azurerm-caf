global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "example"
    region = "region1"
  }
}

api_management = {
  example_apim = {
    name               = "example"
    resource_group_key = "rg1"
    publisher_name     = "My Company"
    publisher_email    = "company@terraform.io"
    sku_name           = "Consumption_0"
  }
}

api_management_product = {
  example_product1 = {
    api_management = {
      key = "example_apim"
    }
    resource_group = {
      key = "rg1"
    }
    product_id            = "example-product1"
    display_name          = "Example Product 1"
    subscription_required = false
    published             = false
  }
  example_product2 = {
    api_management = {
      key = "example_apim"
    }
    resource_group = {
      key = "rg1"
    }
    product_id            = "example-product2"
    display_name          = "Example Product 2"
    description           = "This is a example api product"
    approval_required     = true
    subscription_required = true
    published             = true
    subscriptions_limit   = 50
    terms                 = "Some legal terms ..."
  }
}

api_management_subscription = {
  example_subscription = {
    api_management = {
      key = "example_apim"
    }
    resource_group = {
      key = "rg1"
    }
    product = {
      key = "example_product2"
    }
    display_name = "Example Subscription"
    state        = "active"
  }
  example_subscription2 = {
    api_management = {
      key = "example_apim"
    }
    resource_group = {
      key = "rg1"
    }
    display_name = "Example Subscription"
    state        = "active"
  }

}