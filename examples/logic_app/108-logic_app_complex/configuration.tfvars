global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

resource_groups = {
  rgwflow1 = {
    name   = "exampleRG1"
    region = "region1"
  }
}

vnets = {
  vnetise1 = {
    resource_group_key = "rgwflow1"
    vnet = {
      name          = "example-vnet1"
      address_space = ["10.0.0.0/22"]
    }
    specialsubnets = {}
    subnets = {
      subnetise1 = {
        name = "isesubnet1"
        cidr = ["10.0.1.0/26"]
        delegation = {
          name               = "integrationServiceEnvironments"
          service_delegation = "Microsoft.Logic/integrationServiceEnvironments"
        }
      }
      subnetise2 = {
        name = "isesubnet2"
        cidr = ["10.0.1.64/26"]
      }
      subnetise3 = {
        name = "isesubnet3"
        cidr = ["10.0.1.128/26"]
      }
      subnetise4 = {
        name = "isesubnet4"
        cidr = ["10.0.1.192/26"]
      }
    }
  }
}

integration_service_environment = {
  ise1 = {
    name                 = "example-ise"
    region               = "region1"
    resource_group_key   = "rgwflow1"
    sku_name             = "Developer_0"
    access_endpoint_type = "Internal"
    subnets = {
      subnet1 = {
        #lz_key = ""
        vnet_key   = "vnetise1"
        subnet_key = "subnetise1"
      }
      subnet2 = {
        #lz_key = ""
        vnet_key   = "vnetise1"
        subnet_key = "subnetise2"
      }
      subnet3 = {
        #lz_key = ""
        vnet_key   = "vnetise1"
        subnet_key = "subnetise3"
      }
      subnet4 = {
        #lz_key = ""
        vnet_key   = "vnetise1"
        subnet_key = "subnetise4"
      }
      #add multiple subnets by extending this block
    }
  }
}
logic_app_integration_account = {
  laia1 = {
    name               = "example-ia"
    region             = "region1"
    resource_group_key = "rgwflow1"
    sku_name           = "Standard"
  }
}
logic_app_workflow = {
  applogic1 = {
    name                                = "workflow1"
    region                              = "region1"
    resource_group_key                  = "rgwflow1"
    integration_service_environment_key = "ise1"
    logic_app_integration_account_key   = "laia1"
    #workflow_parameters
    #workflow_schema
    workflow_version = "1.0.0.0"
    #parameters
  }
}