# Last review :  AzureRM version 3.29.1
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix

resource "azurerm_public_ip_prefix" "pip_prefix" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix_length       = var.prefix_length
  tags                = local.tags
  sku                 = var.sku
  zones                = var.zones
  ip_version          = var.ip_version

}
