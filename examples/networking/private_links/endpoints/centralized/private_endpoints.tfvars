private_endpoints = {
  vnet_01 = { # Key of the virtual network
    # lz_key = ""  # Landingzone key when deployed in remote landing zone
    vnet_key    = "vnet_01"
    subnet_keys = ["subnet_01"]
    # resource_group_key = "" # Key of resource group of the vnet

    storage_accounts = {
      level0 = {
        # name = ""                        # Name of the private endpoint
        # lz_key = ""                      # Key of the landingzone where the storage account has been deployed.
        # resource_group_key = ""          # Key of the resource group where the private endpoint will be created. Default to the vnet's resource group
        # tags
        private_service_connection = {
          name              = "psc-stg-level0"
          subresource_names = ["blob", "table"]
          # request_message = ""
          # is_manual_connection = [true|false]
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["dns1"]
          # ids = []    # List of DNS resource ids
        }
      }
      # level1custom = {
      #   resource_id = "" # Using the created resource id if resource are created outside of CAF
      #
      #   private_service_connection = {
      #     name        = ""
      #   }
      #   private_dns = {
      #     zone_group_name = "default"
      #     # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
      #     keys = ["dns1"]
      #   }
      # }
    }

    # Diagnostics objects are global and inherit from base core landing zones
    diagnostic_storage_accounts = {
      # locally created
      diaglogs = {
        private_service_connection = {
          name              = "psc-stg-diag-diaglogs"
          subresource_names = ["blob", "queue"]
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["dns1"]
        }
      }

      # Create in the launchpad scenario 200
      # As it is a global object, no lz_key is required
      # diaglogs_region1 = {
      #   private_service_connection = {
      #     name              = "psc-stg-diag-diaglogs_region1"
      #     subresource_names = ["blob"]
      #   }

      #   private_dns = {
      #     zone_group_name = "default"
      #     # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
      #     keys = ["dns1"]
      #   }
      # }
    }

    diagnostic_event_hub_namespaces = {
      central_logs_region1 = {
        private_service_connection = {
          name = "psc-evh-central-logs"
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["dns1"]
        }
      }
    }

    keyvaults = {
      kv_rg1 = {
        private_service_connection = {
          name = "psc-kv_rg1"
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["dns1"]
        }
      }
    }

    event_hub_namespaces = {
      evh1 = {
        private_service_connection = {
          name = "psc-evh1"
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["dns1"]
        }
      }
    }

    mssql_servers = {
      sales_rg1 = {
        private_service_connection = {
          name = "psc-mssql"
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["dns1"]
        }
      }
    }

    mysql_servers = {
      sales-re1 = {
        private_service_connection = {
          name = "psc-myssql-sales-re1"
        }

        private_dns = {
          zone_group_name = "default"
          keys            = ["dns1"]
        }
      }
    }

    redis_caches = {
      sales_rc1 = {
        private_service_connection = {
          name = "psc-redis-sales-rc1"
        }

        private_dns = {
          zone_group_name = "default"
          keys            = ["dns1"]
        }
      }
    }

    azure_container_registries = {
      acr1 = {
        private_service_connection = {
          name = "psc-acr-sales-acr1"
        }

        private_dns = {
          zone_group_name = "default"
          keys            = ["dns1"]
        }
      }
    }
  }
}