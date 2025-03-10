security = {
  security_center_subscription_pricings = {
    vm = {
      # Free or Standard
      tier = "Standard"
      # Depends on the resource_type
      subplan = "P2"
      # can be one of: Api, AppServices, Arm, CloudPosture, ContainerRegistry, Containers, CosmosDbs, Dns, KeyVaults, KubernetesService, OpenSourceRelationalDatabases, SqlServers, SqlServerVirtualMachines, StorageAccounts, VirtualMachines
      resource_type = "VirtualMachines"
      # extensions list : https://learn.microsoft.com/en-us/rest/api/defenderforcloud/pricings/get?view=rest-defenderforcloud-2024-01-01&tabs=HTTP#extension
      extensions = {
        agent_less_scan = {
          name = "AgentlessVmScanning"
        }
      }
    }
    kv = {
      tier          = "Standard"
      resource_type = "KeyVaults"
    }
  }
}
