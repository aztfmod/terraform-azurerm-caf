azure_container_registries = {
  acr1 = {
    name                          = "acr-test"
    resource_group_key            = "rg1"
    sku                           = "Premium"
    public_network_access_enabled = false
    georeplications = {
      region2 = {
        tags = {
          region = "australiacentral"
          type   = "acr_replica"
        }
      }
      region3 = {
        tags = {
          region = "westeurope"
          type   = "acr_replica"
        }
      }
    }

  }
}