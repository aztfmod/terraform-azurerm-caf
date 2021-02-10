resource "azurerm_virtual_machine_extension" "domainJoin" {
  for_each = var.extension_name == "microsoft_azure_domainJoin" ? toset(["enabled"]) : toset([])
  name                       = "microsoft_azure_domainJoin"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = try(var.extension.type_handler_version, "1.3")
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, true)
  
  lifecycle {
    ignore_changes = [
      "settings",
      "protected_settings",
    ]
  }

  settings = <<SETTINGS
    {
        "Name": "${var.extension.domain_name}",
        "OUPath": "${var.extension.ou_path}",
        "User": "${var.extension.user}",
        "Restart": "${var.extension.restart}",
        "Options": "${var.extension.options}"
    }
    
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
         "Password": "${data.azurerm_key_vault_secret.wvd_client_secret.value}"
  }
PROTECTED_SETTINGS

  # tags {
  #   BUC             = "${var.tagBUC}"
  #   SupportGroup    = "${var.tagSupportGroup}"
  #   AppGroupEmail   = "${var.tagAppGroupEmail}"
  #   EnvironmentType = "${var.tagEnvironmentType}"
  #   CustomerCRMID   = "${var.tagCustomerCRMID}"
  # }
}



resource "azurerm_virtual_machine_extension" "additional_session_host_dscextension" {
  for_each = var.extension_name == "additional_session_host_dscextension" ? toset(["enabled"]) : toset([])
  name                       = "additional_session_host_dscextension"
  # location                   = "${var.region}"
  # resource_group_name        = "${var.resource_group_name}"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true
  depends_on                 = ["azurerm_virtual_machine_extension.domainJoin"]

  settings = <<SETTINGS
{
    "modulesURL": "${var.extension.base_url}/DSC/Configuration.zip",
    "configurationFunction": "Configuration.ps1\\RegisterSessionHost",
     "properties": {
        "TenantAdminCredentials":{
          "userName":"${data.azurerm_key_vault_secret.wvd_client_id.value}",
          "password":"PrivateSettingsRef:tenantAdminPassword"
        },
        "RDBrokerURL":"${var.extension.RDBrokerURL}",
        "DefinedTenantGroupName":"${var.extension.existing_tenant_group_name}",
        "TenantName":"${var.extension.wvd_tenant_name}",
        "HostPoolName":"${var.extension.host_pool_name}",
        "Hours":"${var.extension.registration_expiration_hours}",
        "isServicePrincipal":"${var.extension.is_service_principal}",
        "AadTenantId":"${data.azurerm_key_vault_secret.wvd_tenant_id.value}"
                        
  }
}
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
{
  "items":{
    "tenantAdminPassword":"${data.azurerm_key_vault_secret.wvd_domain_password.value}"
  }
}
PROTECTED_SETTINGS

  # tags {
  #   BUC             = "${var.tagBUC}"
  #   SupportGroup    = "${var.tagSupportGroup}"
  #   AppGroupEmail   = "${var.tagAppGroupEmail}"
  #   EnvironmentType = "${var.tagEnvironmentType}"
  #   CustomerCRMID   = "${var.tagCustomerCRMID}"
  # }
}

data "azurerm_key_vault_secret" "wvd_client_id" {
name = format("%s-client-id", var.extension.secret_prefix)
key_vault_id = var.keyvault_id
}

data "azurerm_key_vault_secret" "wvd_client_secret" {
name = format("%s-client-secret", var.extension.secret_prefix)
key_vault_id = var.keyvault_id
}

data "azurerm_key_vault_secret" "wvd_tenant_id" {
name = format("%s-tenant-id", var.extension.secret_prefix)
key_vault_id = var.keyvault_id
}

data "azurerm_key_vault_secret" "wvd_domain_password" {
name = "wvd-domain-password"
key_vault_id = var.keyvault_id
}

