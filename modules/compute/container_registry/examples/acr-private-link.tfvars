global_settings = {
  convention     = "cafrandom"
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "southeastasia"
    region2 = "eastasia"
    region3 = "westeurope"
  }
}


resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  acr_region1 = {
    name = "acr"
  }
  vnet_region1 = {
    name = "acr-vnet"
  }
}

azure_container_registries = {
  acr1 = {
    name                       = "acr-test"
    resource_group_key         = "acr_region1"
    sku                        = "Premium"
    georeplication_region_keys = ["region2", "region3"]

    private_links = {
      hub_rg1-jumphost = {
        name               = "acr-test-private-link"
        resource_group_key = "vnet_region1"
        vnet_key           = "hub_rg1"
        subnet_key         = "jumphost"
        private_service_connection = {
          name                 = "acr-test-private-link-psc"
          is_manual_connection = false
        }
      }
    }

    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_container_registry"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}


vnets = {
  hub_rg1 = {
    resource_group_key = "vnet_region1"
    vnet = {
      name          = "hub"
      address_space = ["100.64.100.0/22"]
    }
    specialsubnets = {}
    subnets = {
      jumphost = {
        name             = "jumphost"
        cidr             = ["100.64.103.0/27"]
        service_endpoint = ["Microsoft.ContainerRegistry"]
      }
    }
  }

}


#
# Define the settings for log analytics workspace and solution map
#
log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "acr_region1"

    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_container_registry"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}


diagnostics_destinations = {
  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_region1"
      log_analytics_destination_type = "Dedicated"
    }
  }
}

#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  log_analytics = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["Audit", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", true, false, 7],
      ]
    }
  }

  azure_container_registry = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["ContainerRegistryRepositoryEvents", true, false, 7],
        ["ContainerRegistryLoginEvents", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", true, false, 7],
      ]
    }
  }

}
