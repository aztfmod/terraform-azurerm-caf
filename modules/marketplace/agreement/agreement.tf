resource "azurerm_marketplace_agreement" "Marketplace_agreement" {
  publisher = try(var.settings.publisher, null)
  offer     = try(var.settings.offer, null)
  plan      = try(var.settings.plan, null)
}