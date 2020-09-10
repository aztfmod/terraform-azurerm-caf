locals {
  convention       = "cafrandom"
  name             = "caftest-vnet"
  name_la          = "aztfmodcaftestlavalid"
  name_diags       = "caftestdiags"
  location         = "southeastasia"
  prefix           = ""
  max_length       = ""
  postfix          = ""
  enable_event_hub = false
  resource_groups = {
    test = {
      name     = "test-caf-aznetsimple"
      location = "southeastasia"
    },
  }
  tags = {
    environment = "DEV"
    owner       = "CAF"
  }
  solution_plan_map = {
    NetworkMonitoring = {
      "publisher" = "Microsoft"
      "product"   = "OMSGallery/NetworkMonitoring"
    },
  }

  name_ddos = "test_ddos"

  vnet_config = {
    vnet = {
      name          = "TestVnet"
      address_space = ["10.0.0.0/25", "192.168.0.0/24"]
      dns           = ["192.168.0.16", "192.168.0.64"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name              = "AzureFirewallSubnet"
        cidr              = ["10.0.0.0/26"]
        service_endpoints = []
      }
    }
    subnets = {
      subnet1 = {
        name              = "Network_Monitoring"
        cidr              = ["10.0.0.64/26"]
        service_endpoints = []
        nsg_name          = "network_monitoring_nsg"
        nsg = [
          {
            name                       = "W32Time",
            priority                   = "100"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "UDP"
            source_port_range          = "*"
            destination_port_range     = "123"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          },
          {
            name                       = "RPC-Endpoint-Mapper",
            priority                   = "101"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "UDP"
            source_port_range          = "*"
            destination_port_range     = "135"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          },
          {
            name                       = "Kerberos-password-change",
            priority                   = "102"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "*"
            source_port_range          = "*"
            destination_port_range     = "464"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          },
          {
            name                       = "RPC-Dynamic-range",
            priority                   = "103"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "tcp"
            source_port_range          = "*"
            destination_port_range     = "49152-65535"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          },
          {
            name                       = "RPC-Dynamic-range",
            priority                   = "103"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "tcp"
            source_port_range          = "*"
            destination_port_range     = "49152-65535"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      }
    }
    diagnostics = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, true, 60],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 60],
      ]
    }
  }
}