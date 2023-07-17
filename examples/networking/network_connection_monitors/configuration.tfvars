log_analytics = {
  law1 = {
    name               = "networking_monitoring_amsterdam"
    resource_group_key = "networking_test_amsterdam_infra"
  }
}

network_connection_monitors = {
  monitor1 = {
    name   = "ping-test"
    notes  = "room for notes..."
    region = "region1"
    #network_watcher_resource_group_name = "" // optional, can be guessed
    #network_watcher_name                = "" // optional, can be guessed

    output_workspaces = {
      workspace_1 = {
        key = "law1"
        #lz_key = "levelX" //(optional)
      }
      #workspace_2 = {
      #  id = "foo/baz/id" //(optional)
      #}
    }



    endpoints = {
      #endpoint_key_1 = {
      #  name                         = "endpoint_name_1"
      #  address                      = "1.1.1.1"                //(optional)
      #  coverage_level               = "Default"                //(optional)
      #  excluded_ip_addresses        = ["2.2.2.2"]              //(optional)
      #  included_ip_addresses        = ["1.1.1.1"]              //(optional)
      #  target_resource_id           = "foo/bar/baz/3423432423" //(optional)
      #  target_resource_type         = "AzureVM"                //(optional) resource_type as expected by azurerm_network_connection_monitor - target_resource_type 
      #  target_resource_key          = "vm_1"                   //(optional)
      #  target_resource_lz_key       = "level1"                 //(optional)
      #  target_resource_key_caf_type = "level1"                 //(optional) resource_type as expected by caf for state lookups
      #}
      test_vm_1 = {
        name                 = "endpoint_vm_1"
        target_resource_type = "AzureVM"      //(optional) resource_type as expected by azurerm_network_connection_monitor - target_resource_type 
        target_resource_key  = "amsterdam_vm" //(optional)
        #target_resource_lz_key      = "level1"           //(optional)
        target_resource_key_caf_type = "virtual_machines" //(optional) resource_type as expected by caf for state lookups
      }
      test_vm_2 = {
        name                 = "endpoint_vm_2"
        target_resource_type = "AzureVM"      //(optional)
        target_resource_key  = "frankfurt_vm" //(optional)
        #target_resource_lz_key      = "level1"          //(optional)
        target_resource_key_caf_type = "virtual_machines" //(optional)
      }
    }
    test_configurations = {
      test_configuration_key_1 = {
        name                      = "test_configuration_name_1"
        protocol                  = "Icmp"
        test_frequency_in_seconds = "60" //(optional)
        icmp_configuration = {           //(optional)
          trace_route_enabled = true     //(optional)
        }
        preferred_ip_version = "IPv4" //(optional)
        success_threshold = {
          checks_failed_percent = 90
          round_trip_time_ms    = 20
        }
      }

      test_configuration_key_2 = {
        name                      = "test_configuration_name_2"
        protocol                  = "Tcp"
        test_frequency_in_seconds = "60" //(optional)
        tcp_configuration = {
          port                      = 22
          trace_route_enabled       = true //(optional)
          destination_port_behavior = "ListenIfAvailable"
        }
        preferred_ip_version = "IPv4" //(optional)
      }
      test_configuration_key_3 = {
        name                      = "test_configuration_name_3"
        protocol                  = "Http"
        test_frequency_in_seconds = "60" //(optional)
        http_configuration = {
          port                     = 80      //(optional)
          method                   = "Get"   //(optional)
          path                     = "/"     //(optional)
          prefer_https             = false   //(optional)
          valid_status_code_ranges = ["2xx"] //(optional)
          request_headers = {
            key1 = {
              header_name  = "foo"
              header_value = "baz"
            }
            key2 = {
              header_name  = "auth"
              header_value = "nope"
            }
          }
        }
        preferred_ip_version = "IPv4" //(optional)
      }
    }

    test_groups = {
      test_group_1 = {
        name                       = "foo-test-group"
        source_endpoint_names      = ["endpoint_vm_1"]
        destination_endpoint_names = ["endpoint_vm_2"]
        test_configuration_names   = ["test_configuration_name_1"]
        enabled                    = true //(optional)
      }
      test_group_2 = {
        name                       = "tcp-test-group"
        source_endpoint_names      = ["endpoint_vm_1"]
        destination_endpoint_names = ["endpoint_vm_2"]
        test_configuration_names   = ["test_configuration_name_2"]
        enabled                    = true //(optional)
      }
      test_group_3 = {
        name                       = "http-test-group"
        source_endpoint_names      = ["endpoint_vm_1"]
        destination_endpoint_names = ["endpoint_vm_2"]
        test_configuration_names   = ["test_configuration_name_3"]
        enabled                    = true //(optional)
      }
    }

  }
}

//add the networking-watcher vm-extension to the utilized VMs
# virtual_machine_extensions = {
#   generic_extensions = {
#     NW = {
#       publisher               = "Microsoft.Azure.NetworkWatcher"
#       name                    = "NetworkWatcher"
#       type                    = "NetworkWatcherAgentLinux"
#       type_handler_version    = "1.4"
#       autoUpgradeMinorVersion = true
#     }
#   }
# }

