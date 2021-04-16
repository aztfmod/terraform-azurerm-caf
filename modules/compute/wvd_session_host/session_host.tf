# resource "azurecaf_name" "manageddb" {

#   name          = var.settings.name
#   resource_type = "azurerm_mssql_database"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
# }

resource "azurerm_template_deployment" "sessionhost" {

  name                = var.settings.name
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)
  
  parameters_body = jsonencode(local.parameters_body)

  deployment_mode = "Incremental"

  
}

# resource "null_resource" "destroy_sessionhost" {

#   triggers = {
#     resource_id = lookup(azurerm_template_deployment.sessionhost.outputs, "id")
#   }

#   provisioner "local-exec" {
#     command     = format("%s/scripts/destroy_resource.sh", path.module)
#     when        = destroy
#     interpreter = ["/bin/bash"]
#     on_failure  = fail

#     environment = {
#       RESOURCE_IDS = self.triggers.resource_id
#     }
#   }

# }

# # Generate random admin password if not provided in the attribute administrator_login_password
# resource "random_password" "mysql_admin" {
#   count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

#   length           = 32
#   special          = true
#   override_special = "_%@"

# }

# # Store the generated password into keyvault
# resource "azurerm_key_vault_secret" "mysql_admin_password" {
#   count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

#   name         = format("%s-password", azurerm_template_deployment.sessionhost.result)
#   value        = random_password.mysql_admin.0.result
#   key_vault_id = var.keyvault_id

#   lifecycle {
#     ignore_changes = [
#       value
#     ]
#   }
# }

data "azurerm_key_vault_secret" "wvd_domain_password" {
  name = "newwvd-admin-password"
  key_vault_id = var.key_vault_id
  #key_vault_id = data.azurerm_key_vault_secret.wvd-domain-password.value
}

data "azurerm_key_vault_secret" "wvd_hostpool_token" {
  name = "newwvd-hostpool-token"
  key_vault_id = var.key_vault_id
  #key_vault_id = data.azurerm_key_vault_secret.wvd-domain-password.value
}

data "azurerm_key_vault_secret" "wvd_vm_password" {
  name = "newwvd-vm-password"
  key_vault_id = var.key_vault_id
  #key_vault_id = data.azurerm_key_vault_secret.wvd-domain-password.value
}


