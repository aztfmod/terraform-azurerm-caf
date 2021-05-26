resource "azurerm_template_deployment" "sessionhost" {

  name                = var.settings.name
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)

  parameters_body = jsonencode(local.parameters_body)

  deployment_mode = "Incremental"


}

resource "null_resource" "destroy_sessionhost" {

  triggers = {
    resource_id = lookup(azurerm_template_deployment.sessionhost.outputs, "id")
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/destroy_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE_IDS = self.triggers.resource_id
    }
  }

}


data "azurerm_key_vault_secret" "wvd_domain_password" {
  name         = "newwvd-admin-password"
  key_vault_id = try(var.keyvaults[var.settings.administrator.landingzone_key][var.settings.administrator.keyvault_key].id, var.keyvaults[var.settings.administrator.lz_key][var.settings.administrator.keyvault_key].id, null)
}

data "azurerm_key_vault_secret" "wvd_hostpool_token" {
  name         = "newwvd-hostpool-token"
  key_vault_id = try(var.keyvaults[var.settings.hostpoolToken.landingzone_key][var.settings.hostpoolToken.keyvault_key].id, var.keyvaults[var.settings.hostpoolToken.lz_key][var.settings.hostpoolToken.keyvault_key].id, null)
}

data "azurerm_key_vault_secret" "wvd_vm_password" {
  name         = "newwvd-vm-password"
  key_vault_id = try(var.keyvaults[var.settings.vmadministrator.landingzone_key][var.settings.vmadministrator.keyvault_key].id, var.keyvaults[var.settings.vmadministrator.lz_key][var.settings.vmadministrator.keyvault_key].id, null)
}




