data "azuread_group" "group" {
  display_name = var.settings.display_name
}