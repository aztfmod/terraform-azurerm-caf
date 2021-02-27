
azurerm_firewall_network_rule_collection_definition = {
  ip_group = {
    name     = "ip_group"
    action   = "Allow"
    priority = 100
    ruleset = {
      aks = {
        name = "ip_group"
        source_ip_groups_keys = [
          "ip_group1"
        ]
        destination_ports = [
          "443",
        ]
        destination_ip_groups_keys = [
          "ip_group1"
        ]
        protocols = [
          "TCP",
        ]
      }
    }
  }
}