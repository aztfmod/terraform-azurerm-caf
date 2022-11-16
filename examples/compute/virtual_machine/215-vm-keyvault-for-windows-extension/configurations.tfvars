# set default region to region1=eastus2
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}
# all resources in this example will go into this single resource group
resource_groups = {
  rg1 = {
    name = "example-vm-keyvault-for-windows"
  }
}