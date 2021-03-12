azurerm_firewall_nat_rule_collection_definition = {
  ip_group = {
    name     = "ip_group"
    action   = "Dnat"
    priority = 100
    ruleset = {
      ip_group = {
        name = "ip_group"
        source_ip_groups_keys = [
          "ip_group1"
        ]
        destination_ports = [
          "443"
        ]
        destination_addresses_public_ips_keys = [
          "firewall_re1"
        ]
        protocols = [
          "TCP",
        ]
        translated_port    = 53
        translated_address = "8.8.8.8"
      },
    }
  }
}