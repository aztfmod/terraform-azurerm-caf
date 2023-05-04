resource "azurerm_sentinel_watchlist_item" "watchlist_item" {
  name         = var.name
  watchlist_id = var.watchlist_id
  properties   = var.properties
}
