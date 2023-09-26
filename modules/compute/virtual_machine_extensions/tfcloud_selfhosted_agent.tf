resource "random_integer" "tfcloud_selfhosted_agent" {
  count = var.extension_name == "tfcloud_selfhosted_agent" ? 1 : 0

  min = 1
  max = 500000
  keepers = {
    sha        = sensitive(format("%s%s", sha256(jsonencode(local.tfcloud_selfhosted_agent_protected_settings)), sha256(try(jsonencode(var.extension.tfcloud_selfhosted_agent.fileUris), ""))))
    num_agents = try(var.extension.num_agents, null)
    token      = local.tfcloud_selfhosted_agent_agent_pat.pat
  }
}

resource "azurerm_virtual_machine_extension" "tfcloud_selfhosted_agent" {
  for_each = var.extension_name == "tfcloud_selfhosted_agent" ? toset(["enabled"]) : toset([])

  name = "install_azure_tfcloud_agent"

  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings           = jsonencode(local.tfcloud_selfhosted_agent_settings)
  protected_settings = jsonencode(local.tfcloud_selfhosted_agent_protected_settings)

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
  tfcloud_selfhosted_agent = can(var.settings.tfcloud_selfhosted_agent) ? {
    file_uris = flatten(
      [
        for file_uris_key, file in try(var.extension.tfcloud_selfhosted_agent.fileUris, {}) : [
          for file_uri_key in file.storage_blob_keys : var.settings.tfcloud_selfhosted_agent.storage_accounts[file.storage_account_key].containers[file.container_key].blobs[file_uri_key].url
        ]
      ]
    )

    storage_account_blobs_urls = try(var.settings.tfcloud_selfhosted_agent.storage_account_blobs_urls, [])
  } : null

  tfcloud_selfhosted_agent_settings = can(var.settings.tfcloud_selfhosted_agent) ? {
    timestamp = random_integer.tfcloud_selfhosted_agent.0.result
    fileUris  = concat(local.tfcloud_selfhosted_agent.file_uris, local.tfcloud_selfhosted_agent.storage_account_blobs_urls)
  } : null

  tfcloud_selfhosted_agent_protected_settings = can(var.settings.tfcloud_selfhosted_agent) ? merge(
    {
      commandToExecute = format("bash %s '%s' '%s' '%s' '%s' '%s' '%s' '%s'", var.extension.agent_init_script, "tfcloud", var.extension.url, local.tfcloud_selfhosted_agent_agent_pat.pat, var.extension.agent_name_prefix, var.extension.num_agents, var.settings.tfcloud_selfhosted_agent.admin_username, var.extension.rover_version)
    },
    {
      managedIdentity = can(var.extension.managed_identity) && can(var.settings.tfcloud_selfhosted_agent) ? {
        objectId = local.tfcloud_selfhosted_agent_agent_managed_identity.object_id
      } : {}
    }
  ) : null


  tfcloud_selfhosted_agent_agent_managed_identity = can(var.extension.managed_identity) && can(var.settings.tfcloud_selfhosted_agent) ? {
    object_id = var.settings.tfcloud_selfhosted_agent.managed_identities[try(var.extension.managed_identity.lz_key, var.client_config.landingzone_key)][var.extension.managed_identity.key].rbac_id
  } : null

  tfcloud_selfhosted_agent_agent_pat = can(var.settings.tfcloud_selfhosted_agent) ? {
    pat = data.azurecaf_environment_variable.token.0.value
  } : null
}
