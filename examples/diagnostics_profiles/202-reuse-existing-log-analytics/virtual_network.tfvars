vnets = {
  vnet_region1 = {
    resource_group_key = "ops"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }
    diagnostic_profiles = {
      operation = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
        # destination_type = "storage" # if using storage account
        # destination_key  = "central_storage"
      }
    }
  }
}
