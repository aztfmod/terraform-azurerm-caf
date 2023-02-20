# Last review :  AzureRM version 2.63.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool

resource "azurerm_public_ip" "pip" {
  name                    = var.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  allocation_method       = var.allocation_method
  sku                     = var.sku
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = var.generate_domain_name_label ? var.name : var.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  zones                   = var.zones
  tags                    = local.tags
  public_ip_prefix_id     = var.public_ip_prefix_id
  ip_tags                 = var.ip_tags
}
