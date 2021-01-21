#
# If the name is not provided, we are generating a random .com domain.
# Mainly used for CI environments
#
resource "random_string" "dns_zone_name" {
  count   = var.settings.name == "" ? 1 : 0
  length  = 32
  special = false
  upper   = false
}

locals {
  dns_zone_name = var.settings.name == "" ? format("%s.com", random_string.dns_zone_name[0].result) : var.settings.name
}


resource "azurerm_dns_zone" "dns_zone" {
  name                = local.dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

