resource "azurecaf_name" "subnet" {

  name          = var.name
  resource_type = "azurerm_subnet"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_subnet" "subnet" {

  name                                           = azurecaf_name.subnet.result
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = var.address_prefixes
  service_endpoints                              = var.service_endpoints
  enforce_private_link_endpoint_network_policies = try(var.enforce_private_link_endpoint_network_policies, false)
  enforce_private_link_service_network_policies  = try(var.enforce_private_link_service_network_policies, false)

  dynamic "delegation" {
    for_each = var.delegation

    content {
      name = lookup(each.value, "name", null)

      service_delegation {
        name    = lookup(each.value.service_delegation, "name", null)
        actions = lookup(each.value.service_delegation, "actions", null)
      }
    }
  }

}