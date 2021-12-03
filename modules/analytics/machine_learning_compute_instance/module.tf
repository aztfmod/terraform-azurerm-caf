resource "azurecaf_name" "mlci" {
  name          = var.settings.name
  resource_type = "azurerm_machine_learning_compute_instance"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_machine_learning_compute_instance" "mlci" {
  name = azurecaf_name.mlci.result

  location                      = var.location
  machine_learning_workspace_id = var.remote_objects.machine_learning_workspace_id
  virtual_machine_size          = var.settings.virtual_machine_size
  authorization_type            = try(var.settings.authorization_type, null)

  dynamic "assign_to_user" {
    for_each = try(var.settings.assign_to_user, null) != null ? [var.settings.assign_to_user] : []

    content {
      object_id = assign_to_user.value.object_id
      tenant_id = coalesce(
        try(assign_to_user.value.tenant_id, null),
        var.client_config.tenant_id
      )
    }
  }

  description = try(var.settings.description, null)

  dynamic "identity" {
    for_each = try(var.settings.identity, null) != null ? [var.settings.identity] : []

    content {
      type = identity.value.type
      identity_ids = coalesce(
        var.settings.identity.identity_ids,
        local.managed_identities
      )
    }

  }

  #It's on the AzureRM provider documentation but it does raises an error.
  #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance
  #local_auth_enabled = try(var.settings.local_auth_enabled,null)

  dynamic "ssh" {
    for_each = try(var.settings.ssh, null) != null ? [var.settings.ssh] : []

    content {
      public_key = ssh.value.public_key
    }
  }

  subnet_resource_id = try(var.remote_objects.subnet_resource_id, null)
  tags               = local.tags

}
