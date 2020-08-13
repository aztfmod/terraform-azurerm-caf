#Reference: https://www.terraform.io/docs/providers/azurerm/r/firewall.html 
resource "azurecaf_naming_convention" "caf_name_afw" {
  name          = var.name
  prefix        = var.prefix != "" ? var.prefix : null
  postfix       = var.postfix != "" ? var.postfix : null
  max_length    = var.max_length != "" ? var.max_length : null
  resource_type = "azurerm_firewall"
  convention    = var.convention
}

resource "azurerm_firewall" "az_firewall" {
  name                = azurecaf_naming_convention.caf_name_afw.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                 = "az_firewall_ip_configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_id
  }
}

