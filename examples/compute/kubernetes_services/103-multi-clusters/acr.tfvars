azure_container_registries = {
  acr1 = {
    name                       = "acr-test"
    resource_group_key         = "aks_re1"
    sku                        = "Premium"
    georeplication_region_keys = ["region2"]

    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_container_registry"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      spoke_aks_re1-aks_nodepool_system = {
        name               = "acr-private-link-spoke_aks-re1"
        resource_group_key = "aks_re1"

        lz_key     = "networking_spoke_aks"
        vnet_key   = "spoke_aks_re1"
        subnet_key = "private_endpoints"

        private_service_connection = {
          name                 = "acr-private-link-psc-re1"
          is_manual_connection = false
          subresource_names    = ["registry"]
        }
      }
      spoke_aks_re2-aks_nodepool_system = {
        name               = "acr-private-link-spoke_aks-re2"
        resource_group_key = "aks_re2"

        lz_key     = "networking_spoke_aks"
        vnet_key   = "spoke_aks_re2"
        subnet_key = "private_endpoints"

        private_service_connection = {
          name                 = "acr-private-link-psc-re2"
          is_manual_connection = false
          subresource_names    = ["registry"]
        }
      }
    }
  }
}