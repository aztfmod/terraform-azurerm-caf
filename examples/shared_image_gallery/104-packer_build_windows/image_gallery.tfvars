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
}

shared_image_galleries = {
  gallery1 = {
    name               = "example104"
    resource_group_key = "sig"
    description        = " "
  }

}

image_definitions = {
  image1 = {
    name               = "image1"
    gallery_key        = "gallery1"
    resource_group_key = "sig"
    os_type            = "Windows"
    publisher          = "MyCompany"
    offer              = "WebServer"
    sku                = "2020.1"
  }
}
