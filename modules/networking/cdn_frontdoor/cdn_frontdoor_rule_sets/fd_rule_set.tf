resource "azurerm_cdn_frontdoor_rule_set" "this" {
  name                     = var.settings.name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
}