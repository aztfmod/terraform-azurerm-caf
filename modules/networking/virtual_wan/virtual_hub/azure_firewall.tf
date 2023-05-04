# naming convention
resource "azurecaf_name" "virtualhub_fw" {
  count = try(var.virtual_hub_config.deploy_firewall, false) ? 1 : 0

  name          = try(var.virtual_hub_config.firewall_name, null)
  resource_type = "azurerm_firewall"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


# As per https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-09-01/azurefirewalls
resource "azurerm_resource_group_template_deployment" "arm_template_vhub_firewall" {
  count               = try(var.virtual_hub_config.deploy_firewall, false) ? 1 : 0
  name                = "arm_template_vhub_firewall"
  resource_group_name = var.resource_group_name

  template_content = file("${path.module}/arm_template_vhub_firewall.json")

  parameters_content = jsonencode(
    {
      vwan_id = {
        value = azurerm_virtual_hub.vwan_hub.id
      }
      name = {
        value = var.virtual_hub_config.firewall_name
      }
      location = {
        value = var.location
      }
      Tier = {
        value = "Standard"
      }
    }
  )
  deployment_mode = "Incremental"
}
