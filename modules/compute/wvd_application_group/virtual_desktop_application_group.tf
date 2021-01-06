# TODO: pending support of this resource type: https://github.com/aztfmod/terraform-provider-azurecaf/issues/76
# resource "azurecaf_name" "dag" {
#   name          = var.name
#   resource_type = "azurerm_virtual_desktop_application_group"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_virtual_desktop_application_group" "dag" {
  #TODO: pending support of this resource type: https://github.com/aztfmod/terraform-provider-azurecaf/issues/76
  #name = azurecaf_name.dag.result
  name                = var.settings.name
  location            = var.location
  resource_group_name = var.resource_group_name
  friendly_name       = try(var.settings.friendly_name, null)
  description         = try(var.settings.description, null)
  type                = var.settings.type
  host_pool_id        = var.host_pool_id
  tags                = local.tags
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "workspaceremoteapp" {
  workspace_id         = var.workspace_id
  application_group_id = azurerm_virtual_desktop_application_group.appgroup.id
}

