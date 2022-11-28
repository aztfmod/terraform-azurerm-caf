private_endpoints = {
  vnet_region1 = {
    # lz_key = ""  # Landingzone key when deployed in remote landing zone
    vnet_key    = "vnet_region1"
    subnet_keys = ["asr_subnet"]

    recovery_vaults = {
      asr1 = {

        # name = ""                        # Name of the private endpoint
        # lz_key = ""                      # Key of the landingzone where the storage account has been deployed.
        # resource_group_key = ""          # Key of the resource group where the private endpoint will be created. Default to the vnet's resource group
        # tags
        private_service_connection = {
          name = "psc-asr"
          # request_message = ""
          # is_manual_connection = [true|false]
        }

        private_dns = {
          zone_group_name = "default"
          # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
          keys = ["dns1"]
        }
      }
    }

  }
}