resource "azurecaf_name" "ase" {
  name          = var.name
  resource_type = "azurerm_app_service_environment"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_template_deployment" "ase" {

  name                = azurecaf_name.ase.result
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)

  parameters_body = jsonencode(local.parameters_body)

  deployment_mode = "Incremental"

  timeouts {
    create = "10h"
    update = "10h"
    delete = "10h"
    read   = "5m"
  }
}

resource "null_resource" "destroy_ase" {

  triggers = {
    resource_id = lookup(azurerm_template_deployment.ase.outputs, "id")
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/destroy_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      RESOURCE_IDS = self.triggers.resource_id
    }
  }

}



# As of writing, the ASE ARM deployment don't return the IP address of the ILB
# ASE. This workaround querys Azure's API to get the values we need for use
# elsewhere in the script.
# See this https://stackoverflow.com/a/49436100
data "external" "ase_ilb_ip" {
  # This calls the Azure CLI then passes the value to jq to return JSON as a single
  # string so that external provider can parse it properly. Otherwise you get an
  # error. See this bug https://github.com/terraform-providers/terraform-provider-external/issues/23
  program = ["bash", "-c", "az resource show --ids ${lookup(azurerm_template_deployment.ase.outputs, "id")}/capacities/virtualip --query '{internalIpAddress: properties.internalIpAddress}' | jq -c"]

  depends_on = [azurerm_template_deployment.ase]
}

