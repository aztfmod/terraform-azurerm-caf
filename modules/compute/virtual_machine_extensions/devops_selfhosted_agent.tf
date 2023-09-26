resource "random_integer" "devops_selfhosted_agent" {
  count = var.extension_name == "devops_selfhosted_agent" ? 1 : 0

  min = 1
  max = 500000
  keepers = {
    sha           = sensitive(format("%s%s", sha256(jsonencode(local.devops_selfhosted_agent_protected_settings)), sha256(try(jsonencode(var.extension.devops_selfhosted_agent.fileUris), ""))))
    num_agents    = try(var.extension.num_agents, null)
    rover_version = try(var.extension.rover_version, null)
    token         = local.devops_selfhosted_agent_agent_pat.pat
  }
}

resource "azurerm_virtual_machine_extension" "devops_selfhosted_agent" {
  for_each = var.extension_name == "devops_selfhosted_agent" ? toset(["enabled"]) : toset([])

  name = "install_azure_devops_agent"

  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings           = jsonencode(local.devops_selfhosted_agent_settings)
  protected_settings = jsonencode(local.devops_selfhosted_agent_protected_settings)

  lifecycle {
    precondition {
      condition = anytrue(
        [
          for status in jsondecode(data.azapi_resource_action.azurerm_virtual_machine_status.output).statuses : "true"
          if status.code == "PowerState/running"
        ]
      )
      error_message = format("The virtual machine (%s) must be in running state to be able to deploy or modify the vm extension.", var.virtual_machine_id)
    }
  }

}

locals {
  devops_selfhosted_agent = can(var.settings.devops_selfhosted_agent) ? {
    file_uris = flatten(
      [
        for file_uris_key, file in try(var.extension.devops_selfhosted_agent.fileUris, {}) : [
          for file_uri_key in file.storage_blob_keys : var.settings.devops_selfhosted_agent.storage_accounts[file.storage_account_key].containers[file.container_key].blobs[file_uri_key].url
        ]
      ]
    )

    storage_account_blobs_urls = try(var.settings.devops_selfhosted_agent.storage_account_blobs_urls, [])
  } : null

  devops_selfhosted_agent_settings = can(var.settings.devops_selfhosted_agent) ? {
    timestamp = random_integer.devops_selfhosted_agent.0.result
    fileUris  = concat(local.devops_selfhosted_agent.file_uris, local.devops_selfhosted_agent.storage_account_blobs_urls)
  } : null

  devops_selfhosted_agent_protected_settings = can(var.settings.devops_selfhosted_agent) ? merge(
    {
      commandToExecute = format("bash %s '%s' '%s' '%s' '%s' '%s' '%s' '%s' '%s'", var.extension.agent_init_script, "azdo", var.extension.url, local.devops_selfhosted_agent_agent_pat.pat, var.extension.agent_name_prefix, var.extension.num_agents, var.settings.devops_selfhosted_agent.admin_username, var.extension.rover_version, var.extension.agent_pool_name)
    },
    {
      managedIdentity = can(var.extension.managed_identity) && can(var.settings.devops_selfhosted_agent) ? {
        objectId = local.devops_selfhosted_agent_agent_managed_identity.object_id
      } : {}
    }
  ) : null


  devops_selfhosted_agent_agent_managed_identity = can(var.extension.managed_identity) && can(var.settings.devops_selfhosted_agent) ? {
    object_id = var.settings.devops_selfhosted_agent.managed_identities[try(var.extension.managed_identity.lz_key, var.client_config.landingzone_key)][var.extension.managed_identity.key].rbac_id
  } : null

  devops_selfhosted_agent_agent_pat = can(var.settings.devops_selfhosted_agent) ? {
    pat = can(var.extension.pats.keyvault_key) || can(var.extension.pats_from_env_variable.variable_name) ? try(data.azurerm_key_vault_secret.agent_pat.0.value, data.azurecaf_environment_variable.token.0.value) : var.extension.pats.value
  } : null
}

# Get PAT token from keyvault
data "azurerm_key_vault_secret" "agent_pat" {
  count = can(var.extension.pats.keyvault_key) ? 1 : 0

  name         = var.extension.pats.secret_name
  key_vault_id = var.settings.devops_selfhosted_agent.keyvaults[try(var.extension.pats.lz_key, var.client_config.landingzone_key)][var.extension.pats.keyvault_key].id
}