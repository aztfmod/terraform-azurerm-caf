azurerm_firewall_application_rule_collection_definition = {
  ip_group = {
    name     = "ip_group"
    action   = "Allow"
    priority = 100
    ruleset = {
      ip_group = {
        name = "ip_group"
        source_ip_groups_keys = [
          "ip_group1"
        ]
        fqdn_tags = [
          "AzureCloud",
        ]
      },
    }
  }
}