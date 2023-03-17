azure_container_registries = {
  acr1 = {
    name               = "acr-test"
    resource_group_key = "aks_re1"
    sku                = "Premium"
    diagnostic_profiles = {
      operations = {
        name             = "acr_logs"
        definition_key   = "azure_container_registry"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
    # georeplication_region_keys = ["region2"]

    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      spoke_aks_re1-aks_nodepool_system = {
        name               = "acr-test-private-link"
        resource_group_key = "aks_re1"

        vnet_key   = "spoke_aks_re1"
        subnet_key = "private_endpoints"

        private_service_connection = {
          name                 = "acr-test-private-link-psc"
          is_manual_connection = false
          subresource_names    = ["registry"]
        }
      }
    }

  }
}