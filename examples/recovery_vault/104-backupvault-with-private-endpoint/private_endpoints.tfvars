private_endpoints = {
  pvtlink_region1 = {
    # lz_key = ""                      # Key of the landingzone if the virtual network is deployed in a remote landing zone
    vnet_key           = "vnet_region1"
    subnet_keys        = ["subnet_001"]
    resource_group_key = "secondary"

    recovery_vaults = {
      asr1 = {

        # name = ""                        # Name of the private endpoint
        # resource_group_key = ""          # Key of the resource group where the private endpoint will be created. Defaults to the vnet's resource group
        private_service_connection = {
          name              = "psc-backup"
          subresource_names = ["AzureBackup"]
          # request_message = ""
          # is_manual_connection = [true|false]
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["backup_region1"]
        }
      }
    }

  }
}