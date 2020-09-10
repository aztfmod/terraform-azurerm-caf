locals {
  convention = "cafrandom"
  name       = "azfwcaf"
  location   = "southeastasia"
  prefix     = ""
  resource_groups = {
    test = {
      name     = "test-caf-azfirewall"
      location = "southeastasia"
    },
  }
  enable_event_hub = true

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

  vnet_config = {
    vnet = {
      name          = "TestVnet"
      address_space = ["10.0.0.0/25"]
      dns           = ["192.168.0.16", "192.168.0.64"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name              = "AzureFirewallSubnet"
        cidr              = "10.0.0.0/26"
        service_endpoints = []
      }
    }
    subnets = {
      subnet1 = {
        name              = "Network_Monitoring"
        cidr              = "10.0.0.64/26"
        service_endpoints = []
        nsg_inbound       = []
        nsg_outbound      = []
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

  az_fw_config = {
    name = "az-fw-caftest"
    diagnostics = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, true, 30],
        ["AzureFirewallNetworkRule", true, true, 30],
      ]
      metric = [
        ["AllMetrics", true, true, 30],
      ]
    }
  }

  ip_addr_config = {
    ip_name           = "caftest-pip-egress"
    allocation_method = "Static"
    #Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure

    #properties below are optional
    sku        = "Standard" #defaults to Basic
    ip_version = "IPv4"     #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both

    diagnostics = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, true, 30],
        ["DDoSMitigationFlowLogs", true, true, 30],
        ["DDoSMitigationReports", true, true, 30],
      ]
      metric = [
        ["AllMetrics", true, true, 30],
      ]
    }
  }
}