
resource "azurecaf_name" "asr_rg_vault" {
  name          = var.settings.name
  resource_type = "azurerm_recovery_services_vault"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_recovery_services_vault" "asr_rg_vault" {
  name                = azurecaf_name.asr_rg_vault.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = local.tags

  soft_delete_enabled = try(var.settings.soft_delete_enabled, true)
  
}


resource "null_resource" "create_identity {

  
  triggers = {
    identity = var.identity
  }

  
  provisioner "local-exec" {
    command     = format("%s/scripts/create_identity.sh", path.module)
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      METHOD                      = "POST"
      ARS_IDENTITY                = var.identity
      
    }
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/create_identity.sh", path.module)
    when        = destroy
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      METHOD                      = "DELETE"
      ARS_IDENTITY                = var.identity
      
    }
  }
}


