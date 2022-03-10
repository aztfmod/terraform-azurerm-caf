
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}
synapse_private_link_hub = {
  syplh1 = {
    name = "example-resource"
    resource_group = {
      key = "rg1"
    }
    location = "eastus"
  }
}