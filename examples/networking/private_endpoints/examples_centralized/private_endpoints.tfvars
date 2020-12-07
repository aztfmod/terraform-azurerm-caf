private_endpoints = {
  ppl1 = {

    storage_accounts = {
      level0 = {
        # name = ""                        # Name of the private endpoint
        # lz_key = ""                      # Key of the landingzone where the storage account has been deployed.
        # resource_group_key = ""          # Key of the resource group where the private endpoint will be created. Default to the vnet's resource group
        # tags
        private_service_connection = {
          name = "psc-stg-level0"
          subresource_names = ["blob", "table"]
          # request_message = ""
          # is_manual_connection = [true|false]
        }
      }
    }

    # Diagnostics objects are global and inherit from base core landing zones
    diagnostic_storage_accounts = {
      # locally created
      diaglogs = {
        private_service_connection = {
          name = "psc-stg-diag-diaglogs"
          subresource_names = ["blob", "queue"]
        }
      }

      # Create in the launchpad scenario 200
      # As it is a global object, no lz_key is required 
      diaglogs_region1 = {
        private_service_connection = {
          name = "psc-stg-diag-diaglogs_region1"
          subresource_names = ["blob"]
        }
      }
    }

    keyvaults = {
      kv_rg1 = {
        private_service_connection = {
          name = "psc-kv_rg1"
        }
      }
    }

    event_hub_namespaces = {
      evh1 = {
        private_service_connection = {
          name = "psc-evh1"
        }
      }
    }
  }
}