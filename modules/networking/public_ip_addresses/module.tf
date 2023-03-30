# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "pip" {
  name                = var.name
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = var.allocation_method
  domain_name_label   = var.generate_domain_name_label ? var.name : var.domain_name_label
  reverse_fqdn        = var.reverse_fqdn
  tags                = merge(local.tags, try(var.tags, {}))
  public_ip_prefix_id = var.public_ip_prefix_id
  ip_tags             = var.ip_tags
  ip_version          = var.ip_version
  sku                 = var.sku
  sku_tier            = var.sku_tier
  zones               = var.zones
}