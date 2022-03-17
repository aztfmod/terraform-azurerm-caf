global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  sig = {
    name = "sig"
  }
  packer = {
    name = "packer"
  }
  build = {
    name = "build"
  }
}

shared_image_galleries = {
  gallery1 = {
    name               = "test1"
    resource_group_key = "sig"
    description        = " "
  }

}

image_definitions = {
  image1 = {
    name               = "image1"
    gallery_key        = "gallery1"
    resource_group_key = "sig"
    os_type            = "Linux"
    publisher          = "MyCompany"
    offer              = "WebServer"
    sku                = "2020.1"
  }
}

managed_identities = {
  example_mi = {
    name               = "example_mi"
    resource_group_key = "sig"
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "sig"
    vnet = {
      name          = "buildvnet"
      address_space = ["10.100.100.0/24"]
    }
    subnets = {
      buildsubnet = {
        name = "buildsubnet"
        cidr = ["10.100.100.0/29"]
      }
    }
  }
}
