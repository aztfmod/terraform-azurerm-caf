resource "azurecaf_name" "mifailover" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_server" //TODO: add support for sql failover group
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

# resource "azurerm_template_deployment" "mifailover" {
#
#   name                = azurecaf_name.mifailover.result
#   resource_group_name = var.resource_group_name

#   template_body = file(local.arm_filename)

#   parameters_body = jsonencode(local.parameters_body)

#   deployment_mode = "Incremental"
# }

