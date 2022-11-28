bastion_hosts = {
  bastion_hub_re1 = {
    name               = "bastion-rg1"
    region             = "region1"
    resource_group_key = "vnet_hub_re1"
    vnet_key           = "hub_re1"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_rg1"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

}