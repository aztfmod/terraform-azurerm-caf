global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  dhg = {
    name   = "dedicated-test"
    region = "region1"
  }
}

dedicated_host_groups = {
  dhg1 = {
    name                        = "example-dhg"
    resource_group_key          = "dhg"
    region                      = "region1"
    platform_fault_domain_count = 2
    automatic_placement_enabled = true
    zones                       = ["1"]
    tags = {
    test = "dhg" }
  }
}

dedicated_hosts = {
  dh1 = {
    name                     = "example-host-dhg"
    dedicated_host_group_key = "dhg1"
    #lz_key = "remote landing zone key"
    region                  = "region1"
    sku_name                = "DSv3-Type1"
    platform_fault_domain   = 1
    auto_replace_on_failure = true
    # license_type = "Windows_Server_Hybrid"
    tags = {
      test = "dhg"
    }
  }

}