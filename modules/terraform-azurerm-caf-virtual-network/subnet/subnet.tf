resource "azurerm_subnet" "v_subnet" {
  # lifecycle {
  #       ignore_changes = [network_security_group_id]
  #   }

  for_each = var.subnets

  name                                           = each.value.name
  resource_group_name                            = var.resource_group
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = each.value.cidr
  service_endpoints                              = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", null)
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", null)

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {}) != {} ? [1] : []

    content {
      name = lookup(each.value.delegation, "name", null)

      service_delegation {
        name    = lookup(each.value.delegation.service_delegation, "name", null)
        actions = lookup(each.value.delegation.service_delegation, "actions", null)
      }
    }
  }

}