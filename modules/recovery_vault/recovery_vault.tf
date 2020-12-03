
resource "azurecaf_name" "asr_rg_vault" {
  name          = var.settings.name
  resource_type = "azurerm_recovery_services_vault"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# resource "azurerm_recovery_services_vault" "asr_rg_vault" {
#   name                = azurecaf_name.asr_rg_vault.result
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku                 = "Standard"
#   tags                = local.tags

#   soft_delete_enabled = try(var.settings.soft_delete_enabled, true)
  
# }

resource "azurerm_resource_group_template_deployment" "asr" {
  name                = "asr-terraform"
  resource_group_name = var.resource_group_name
  template_content    = file(local.arm_filename)
  parameters_content  = jsonencode(local.parameters_body)
  deployment_mode     = "Incremental"
  debug_level         = "requestContent, responseContent"

  timeouts {
    create = "10h"
    update = "10h"
    delete = "10h"
    read   = "5m"
  }

  lifecycle {
    ignore_changes = [
      template_content
    ]
  }
}


resource "null_resource" "backup_con" {
  depends_on = [time_sleep.delay_create]
    
  triggers = {
    asr_id = local.asr_id
    softDeleteFeatureState = try(var.settings.soft_delete_enabled, true)
  }

  
  provisioner "local-exec" {
    command     = format("%s/scripts/backup_config.sh", path.module)
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      METHOD  = "PUT"
      URI     = local.asr_backup_config_uri
      PAYLOAD = local.asr_backup_config
    }
  }

}

locals {
  
  asr_id = jsondecode(azurerm_resource_group_template_deployment.asr.output_content).id.value

  arm_filename = "${path.module}/arm_recovery_vault.json"

  asr_backup_config_uri = format("%s%s%s", 
    "https://management.azure.com", 
    local.asr_id,
    "/backupconfig/vaultconfig?api-version=2019-06-15"
  )

  # enhancedSecurityState must be set to "Enabled" and cannot be removed
  asr_backup_config = jsonencode(
    {
      properties =  {
        softDeleteFeatureState = try(var.settings.soft_delete_enabled, true) ? "Enabled" : "Disabled"
        enhancedSecurityState  = "Enabled"
      }
    }
  )

  parameters_body = {
    name = {
      value = azurecaf_name.asr_rg_vault.result
    }
    resourceGroupName = {
      value = var.resource_group_name
    }
    location = {
      value = var.location
    }
    resourceTags = {
      value = local.tags
    }
  }
}
