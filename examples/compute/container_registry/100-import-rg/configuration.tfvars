
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
  passthrough = true
}

# load_resource_groups = {
#   loaded_rg = {
#     name = "example-virtual-machine-rg1"
#   }
# }

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

public_ip_addresses = {
  example_vm_pip1_rg1 = {
    name                    = "example_vm_pip1"
    resource_group_key      = "reuse"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

azure_container_registries = {
  acr1 = {
    name               = "acr-test9347982y819208"
    resource_group_key = "new"
    sku                = "Premium"
  }
}

