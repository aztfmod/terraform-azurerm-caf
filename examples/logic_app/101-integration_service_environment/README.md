# Azure Logic App

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```



## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

```hcl
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiacentral"
  }
}

resource_groups = {
  rgise1 = {
    name   = "exampleRG1"
    region = "region1"
  }
}

vnets = {
  vnetise1 = {
    resource_group_key = "rgise1"
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
    resource_group_key   = "rgise1"
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
```
# integration_service_environment

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Outputs
| Name | Description |
|------|-------------|

