resource "azurerm_virtual_desktop_application" "da" {
  name                         = var.settings.name
  application_group_id         = var.application_group_id
  friendly_name                = try(var.settings.friendly_name, null)
  description                  = try(var.settings.description, null)
  path                         = var.settings.path
  command_line_argument_policy = var.settings.command_line_argument_policy
  command_line_arguments       = try(var.settings.command_line_arguments, null)
  show_in_portal               = try(var.settings.show_in_portal, null)
  icon_path                    = try(var.settings.icon_path, null)
  icon_index                   = try(var.settings.icon_index, null)
}

