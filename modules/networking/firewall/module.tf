#Reference: https://www.terraform.io/docs/providers/azurerm/r/firewall.html
resource "azurecaf_naming_convention" "fw" {
  name   = var.name
  prefix = var.global_settings.prefix
  # postfix       = var.global_settings.postfix
  max_length    = var.global_settings.max_length
  resource_type = "azurerm_firewall"
  convention    = var.global_settings.convention
}

resource "azurerm_firewall" "fw" {

  name                = azurecaf_naming_convention.fw.result
  resource_group_name = var.resource_group_name
  location            = var.location
  threat_intel_mode   = try(var.settings.threat_intel_mode, "Alert")
  zones               = try(var.settings.zones, null)
  tags                = try(var.tags, null)

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_id
  }
}
