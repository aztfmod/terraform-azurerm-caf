global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope" # You can adjust the Azure Region you want to use to deploy AKS and the related services
    # region2 = "australiacentral"            # Optional - Add additional regions
  }
}

resource_groups = {
  ip_group_re1 = {
    name   = "ip_group_re1"
    region = "region1"
  }
}

ip_groups = {
  ip_group1 = {
    name               = "ip_group1"
    cidrs              = ["10.0.0.0/20"] # if cidrs is defined all vnet & subnet are ignored
    resource_group_key = "ip_group_re1"
  }
  ip_group2 = {
    name               = "ip_group2"
    resource_group_key = "ip_group_re1"
    vnet_key           = "vnet_ip_group_re1"
  }
  ip_group3 = {
    name               = "ip_group3"
    resource_group_key = "ip_group_re1"
    vnet_key           = "vnet_ip_group_re1"
    subnet_keys        = ["subnet1", "subnet2"] # can be either unclared or empty, will take vnet cidr instead
  }
}
