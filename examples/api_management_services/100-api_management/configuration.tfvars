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
    sku_name = "Premium_2"
    
    #additional_location = {
    #  location_1 = {
    #    location = "eastus"
    #    #virtual_network_configuration = {
    #    #  subnet_id = "some_id"
    #    #}
    #  }
    #  location_2 = {
    #    location = "eastus2"
    #    #virtual_network_configuration = {
    #    #  subnet_id = "some_id_2"
    #    #}
    #  }
    #}
    #certificate = {
    #  certificate_1 = {
    #    encoded_certificate = "Asdfasdf"
    #    store_name = "CertificateAuthority"
    #  }
    #}

    client_certificate_enabled = false
    gateway_disabled = false
    #min_api_version = "1.1" # Not sure what a real version is
    zones = []

    identity = {
      type = "SystemAssigned"
      #identity_ids = ["identity.com"]
    }

    #hostname_configuration = {
    #  management = {
    #    management_1 = {
    #      host_name = "some_hostname"
    #      #key_vault_id = "key_vault_id_1.com"
    #    }
    #  }
    #  portal = {
    #    portal_1 = {
    #      host_name = "www.portal.com"
    #      #key_vault_id = "portal_1.com"
    #    }
    #    portal_2 = {
    #      host_name = "www.portal2.com"
    #    }
    #  }
    #  developer_portal = {
    #    developer_portal_1 = {
    #      host_name = "www.developer_portal_1.com"
    #      certificate = "dev_cert"
    #      certificate_password = "somepass"
    #      negotiate_client_certificate = true
    #      #ssl_keyvault_identity_client_id = "ssl_keyvault_identity_client_id"
    #    }
    #  }
    #}
    policy = {
      xml_content = "xml_content"
      #xml_link = "www.xml_link.com"
    }
    protocols = {
      enable_http2 = true
    }
    security = {
      enable_backend_ssl30 = true
    }
    sign_in = {
      enabled = true
    }
    sign_up = {
      enabled = true 
      terms_of_service = {
        consent_required = true
        enabled = true 
        text = "tests"
      }
    }
    tenant_access = {
      enabled = false
    }
    #virtual_network_configuration = {
    #  subnet_id = "some_subnet_id"
    #}
  }
}
