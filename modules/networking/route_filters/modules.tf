resource "azurerm_route_filter" "rtfilter" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags
  rule {
    name        = var.rule_name
    access      = "Allow"       # The access type of the rule. The only possible value is Allow
    rule_type   = "Community"   # The rule type of the rule. The only possible value is Community.
    communities = var.rule_communities
  }
}
