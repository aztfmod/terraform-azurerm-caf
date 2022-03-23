
global_settings = {
  random_length  = "5"
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

resource_groups = {
  vm_region1 = {
    name = "example-virtual-machine-rg1"
  }
}
