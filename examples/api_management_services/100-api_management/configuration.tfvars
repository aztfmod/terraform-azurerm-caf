global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
  random_length = 5
}

resource_groups = {
  test-rg = {
    name = "rg-alz-caf-test-1"
  }
}

api_management = {
  test-account-1 = {
    resource_group = {
      # accepts either id or key to get resource group id
      # id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1"
      # lz_key = "examples"
      key = "test-rg"
    }
    name = "example-apim"
    publisher_name      = "My Company"
    publisher_email     = "company@terraform.io"
    sku_name = "Developer_1"
    
    additional_locations = {
      location_1 = {
        location = "eastus"
        virtual_network_configuration = {
          subnet_id = "some_id"
        }
      }
      location_2 = {
        location = "eastus2"
        virtual_network_configuration = {
          subnet_id = "some_id_2"
        }
      }
    }
    certificate = {
      certificate_1 = {
        encoded_certificate = "Asdfasdf"
        store_name = "store_name_1"
      }
    }

    client_certificate_enabled = false
    gateway_disabled = false
    #min_api_version = "1.1" # Not sure what a real version is
    zones = []

    identity = {
      type = SystemAssigned
      identity_ids = []
    }
  }

}
