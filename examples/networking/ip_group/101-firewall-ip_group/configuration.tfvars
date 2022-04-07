global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope" # You can adjust the Azure Region you want to use to deploy AKS and the related services
    # region2 = "australiacentral"            # Optional - Add additional regions
  }
}


resource_groups = {
  hub_re1 = {
    name   = "hub_re1"
    region = "region1"
  }

  spoke_re1 = {
    name   = "spoke_re1"
    region = "region1"
  }
}

ip_groups = {
  ip_group1 = {
    name               = "ip_group1"
    resource_group_key = "spoke_re1"
    vnet_key           = "vnet_spoke_re1"
    subnet_keys        = ["subnet1", "subnet2"] # can be either unclared or empty, will take vnet cidr instead
  }
}
