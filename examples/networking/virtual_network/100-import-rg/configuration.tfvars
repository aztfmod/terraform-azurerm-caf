
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  passthrough = true
}

resource_groups = {
  reuse = {
    name  = "example-acr-rg1"
    reuse = true
  }
  new = {
    name = "example-acr-rg1"
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "reuse"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}

