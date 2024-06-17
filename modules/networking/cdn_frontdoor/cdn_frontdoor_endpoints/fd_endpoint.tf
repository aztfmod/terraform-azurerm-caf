resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = var.settings.name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
  enabled                  = try(var.settings.enabled, null)
  tags                     = local.tags
}