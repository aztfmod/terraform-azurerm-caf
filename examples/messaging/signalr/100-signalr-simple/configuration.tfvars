global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name   = "signalr-service"
    region = "region1"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "signalr-vnet"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name                                           = "signalr-pr-subnet"
        cidr                                           = ["10.100.100.0/29"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }

  }
  vnet2 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "signalr-vnet2"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name                                           = "signalr-pr-subnet"
        cidr                                           = ["10.100.100.8/29"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }

  }
}

private_dns = {
  dns1 = {
    name               = "test-dns.dn1.internal"
    resource_group_key = "rg1"

    vnet_links = {
      vnet1 = {
        name     = "vnet_01"
        vnet_key = "vnet1"
      }

    }
  }
  dns2 = {
    name               = "test2-dns.dn1.internal"
    resource_group_key = "rg1"

    vnet_links = {
      vnet1 = {
        name     = "vnet_02"
        vnet_key = "vnet2"
      }

    }
  }
}

private_endpoints = {
  vnet1 = {
    # lz_key = ""
    vnet_key    = "vnet1"
    subnet_keys = ["subnet1"]

    signalr_services = {
      service1 = { # signalr service key
        name = "signalr-pe1"
        # lz_key = ""
        private_service_connection = {
          name = "psc-signalr"
        }
        private_dns = {
          zone_group_name = "default"
          # lz_key = ""
          keys = ["dns1"]
        }
      }
    }
  }
  vnet2 = {



    # lz_key = ""
    vnet_key    = "vnet2"
    subnet_keys = ["subnet1"]

    signalr_services = {
      service1 = { # signalr service key
        name = "signalr-pe2"
        # lz_key = ""
        private_service_connection = {
          name = "psc-signalr2"
        }
        private_dns = {
          zone_group_name = "default"
          # lz_key = ""
          keys = ["dns2"]
        }
      }
    }
  }
}


signalr_services = {
  service1 = {
    name = "example_signalr"
    resource_group = {
      # lz_key = ""
      key = "rg1"
    }

    sku = {
      name     = "Standard_S1"
      capacity = 1
    }

    cors = {
      allowed_origins = ["http://example.com"]
    }

    ## Refactored in 5.5.2 see below
    # features = {
    #   feature1 = {
    #     flag  = "ServiceMode"
    #     value = "Serverless" # Default Serverless Classic
    #   }
    #   feature2 = {
    #     flag  = "EnableMessagingLogs"
    #     value = "True" # True / False
    #   }
    #   feature3 = {
    #     flag  = "EnableConnectivityLogs"
    #     value = "True" # True / False
    #   }
    # }

    service_mode              = "Serverless"
    messaging_logs_enabled    = true
    connectivity_logs_enabled = true

    upstream_endpoints = { # service mode has to be serverless
      endpoint1 = {
        url_template     = "http://foo.com"
        category_pattern = ["connections", "messages"]
        event_pattern    = ["*"]
        hub_pattern      = ["hub1"]
      }
      # endpoint2 = {
      #   url_template     = "http://foo2.com"
      #   category_pattern = ["connections"]
      #   event_pattern    = ["*"]
      #   hub_pattern      = ["hub1"]
      # }
    }


    network_acl = {
      # When default action is Allow, allowed_request_types cannot be set and vice versa
      # allowed_request_types and denied_request_types cannot be set together.

      default_action = "Deny" # Allow / Deny
      public_network = {
        allowed_request_types = [] # ClientConnection, ServerConnection, RESTAPI, Trace
        # denied_request_types = []
      }


      # NOTE: private endpoints id can only be added AFTER Private endpoint has been created and add the ID below.
      # NOTE: private endpoint key reference not possible due to cyclic dependency

      # private_endpoints = {
      #   pe1 = {
      #     id = "/subscriptions/xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/xxxx-resourcegroup/providers/Microsoft.Network/privateEndpoints/xxxx-pe"
      #     allowed_request_types = ["ServerConnection"]
      #   }
      #   pe2 = {
      #     id = "/subscriptions/xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/xxxx-resourcegroup/providers/Microsoft.Network/privateEndpoints/xxxx-pe"
      #     allowed_request_types = ["RESTAPI"]
      #   }
      # }

    }
  }
}