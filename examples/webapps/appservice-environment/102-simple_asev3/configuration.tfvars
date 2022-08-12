global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  ase_region1 = {
    name   = "ase"
    region = "region1"
  }
  asp_project1_region1 = {
    name   = "asp-project1"
    region = "region1"
  }
  asp_project2_region1 = {
    name   = "asp-project2"
    region = "region1"
  }
  networking_region1 = {
    name   = "ase-networking"
    region = "region1"
  }
}

app_service_environments_v3 = {
  ase1 = {
    resource_group_key        = "ase_region1"
    name                      = "ase01"
    vnet_key                  = "ase_region1"
    subnet_key                = "ase1"
    internalLoadBalancingMode = "Web, Publishing"
  }
}

app_service_plans = {
  asp1 = {
    app_service_environment_key = "ase1"
    resource_group_key          = "asp_project1_region1"

    name = "ase1-asp01"
    kind = "Windows"

    sku = {
      tier             = "IsolatedV2"
      size             = "I1v2"
      capacity         = "1"
      per_site_scaling = true
    }
  },
  asp2 = {
    app_service_environment_key = "ase1"
    resource_group_key          = "asp_project2_region1"

    name = "ase1-asp02"
    kind = "Linux"

    //When creating a Linux App Service Plan, the reserved field must be set to true
    reserved = true

    sku = {
      tier             = "IsolatedV2"
      size             = "I1v2"
      capacity         = "1"
      per_site_scaling = true
    }
  }
}

vnets = {
  ase_region1 = {
    resource_group_key = "networking_region1"
    vnet = {
      name          = "ase"
      address_space = ["172.25.88.0/21"]
    }
    specialsubnets = {}
    subnets = {
      ase1 = {
        name              = "ase1"
        cidr              = ["172.25.92.0/25"]
        service_endpoints = ["Microsoft.Sql"]
        delegation = {
          name               = "Microsoft.Web.hostingEnvironments"
          service_delegation = "Microsoft.Web/hostingEnvironments"
          action             = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
      ase2 = {
        name              = "ase2"
        cidr              = ["172.25.92.128/25"]
        service_endpoints = ["Microsoft.Sql"]
        delegation = {
          name               = "Microsoft.Web.hostingEnvironments"
          service_delegation = "Microsoft.Web/hostingEnvironments"
          action             = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
      ase3 = {
        name              = "ase3"
        cidr              = ["172.25.93.0/25"]
        service_endpoints = ["Microsoft.Sql"]
        delegation = {
          name               = "Microsoft.Web.hostingEnvironments"
          service_delegation = "Microsoft.Web/hostingEnvironments"
          action             = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}