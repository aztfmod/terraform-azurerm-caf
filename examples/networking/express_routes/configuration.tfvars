global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}
resource_groups = {
  vm_region1 = {
    name = "example-express-route-re1"
  }
}

express_route_circuits = {
  er1 = {
    name                  = "errg1"
    resource_group_key    = "vm_region1"
    service_provider_name = "Equinix"
    peering_location      = "Silicon Valley"
    tier                  = "Standard"
    bandwidth_in_mbps     = 50
  }
}

express_route_circuit_authorizations = {
  key1 = {
    name               = "er_australiacentral_np"
    resource_group_key = "vm_region1 "
    express_route_key  = "er1"
  }
  key2 = {
    name               = "er_australiacentral_prod"
    resource_group_key = "vm_region1 "
    express_route_key  = "er1"
  }
}