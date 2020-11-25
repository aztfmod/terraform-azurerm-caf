global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}
resource_groups = {
  vm_region1 = {
    name = "example-express-route-re1"
  }
}


vnets = {
  vnet_spoke_data_re1 = {
    resource_group_key = "vnet_re1"
    vnet = {
      name          = "databricks"
      address_space = ["10.150.100.0/24"]
    }
    specialsubnets = {}
    subnets = {} 
    }
  }

virtual_network_gateways = {
  name = "mygateway"
  
    