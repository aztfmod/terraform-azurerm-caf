azurerm_firewalls = {
  fw_re1 = {
    name               = "egress"
    resource_group_key = "hub_re1"
    vnet_key           = "vnet_hub_re1"
    #public_ip_key      = "firewall_re1" # if this is defined, public_ip_keys is ignored
    public_ip_keys = ["firewall_re1", "firewall_pip2_re1"]
    # Also possible to specify an existing key
    #public_ip_id = "Azure_resource_id"


    azurerm_firewall_network_rule_collections = [
      "ip_group"
    ]

    azurerm_firewall_application_rule_collections = [
      "ip_group",
    ]

    azurerm_firewall_nat_rule_collections = [
      "ip_group",
    ]
  }
}


