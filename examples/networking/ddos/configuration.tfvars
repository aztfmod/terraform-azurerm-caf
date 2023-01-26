#Please don't include this example in CI due to DDOS Cost consumption

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  ddosrg = {
    name   = "ddos"
    region = "region1"
  }
}

ddos_services = {
  ddos = {
    name               = "ddos-testplan"
    resource_group_key = "ddosrg"
  }
}

vnets = {
  vnet1 = {
    # ddos_services_lz_key = "" #If the reference of Remote DDOS subscription plan is being inferred
    ddos_services_key  = "ddos"
    resource_group_key = "ddosrg"
    vnet = {
      name          = "test-vnet"
      address_space = ["10.0.0.0/16"]
    }
    specialsubnets = {}
  }
}