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

vnets = {
  example_vnet = {
    resource_group_key = "rg1"

    vnet = {
      name          = "test"
      address_space = ["10.0.0.0/16"]
    }

    subnets = {
      example_subnet_key = {
        name    = "example_subnet"
        cidr    = ["10.0.1.0/26"]
        nsg_key = "example_nsg"
      }

    }
    specialsubnets = {}
  }
}

api_management = {
  example_apim = {
    name                 = "example-apim"
    resource_group_key   = "rg1"
    publisher_name       = "My Company"
    publisher_email      = "company@terraform.io"
    sku_name             = "Developer_1"
    virtual_network_type = "Internal"
    virtual_network_configuration = {
      vnet_key   = "example_vnet"
      subnet_key = "example_subnet_key"
    }
  }
}