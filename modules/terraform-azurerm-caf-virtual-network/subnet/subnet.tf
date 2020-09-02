resource "azurerm_subnet" "subnet" {

  name                                           = var.name
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