resource "azurecaf_name" "acg" {
  name          = var.settings.name
  resource_type = "azurerm_containerGroups"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

data "azurerm_key_vault_secret" "image_registry_credential_password" {
  for_each = {
    for irc_key, irc in try(var.settings.image_registry_credentials, {}) : irc_key => irc if try(irc.keyvault_key, null) != null
  }
  key_vault_id = try(var.combined_resources.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key].id, null)
  name         = try(var.dynamic_keyvault_secrets[each.value.keyvault_key][each.value.password_secret_key].secret_name, each.value.password_secret_name, null)
}

data "azurerm_key_vault_secret" "image_registry_credential_username" {
  for_each = {
    for irc_key, irc in try(var.settings.image_registry_credentials, {}) : irc_key => irc if try(irc.keyvault_key, null) != null
  }
  key_vault_id = try(var.combined_resources.keyvaults[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key].id, null)
  name         = try(var.dynamic_keyvault_secrets[each.value.keyvault_key][each.value.username_secret_key].secret_name, each.value.username_secret_name, null)
}

resource "azurerm_container_group" "acg" {
  name                = azurecaf_name.acg.result
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = try(var.settings.os_type, "Linux")
  dns_name_label      = try(var.settings.dns_name_label, null)
  tags                = merge(local.tags, try(var.settings.tags, null))
  ip_address_type     = try(var.settings.ip_address_type, "Public")
  restart_policy      = try(var.settings.restart_policy, "Always")
  network_profile_id  = try(var.combined_resources.network_profiles[var.client_config.landingzone_key][var.settings.network_profile.key].id, null)

  dynamic "exposed_port" {
    for_each = try(var.settings.exposed_port, [])

    content {
      port     = exposed_port.value.port
      protocol = upper(exposed_port.value.protocol)
    }
  }

  # Create containers based on for_each
  dynamic "container" {
    for_each = local.combined_containers

    content {
      name                         = container.value.name
      image                        = container.value.image
      cpu                          = container.value.cpu
      memory                       = container.value.memory
      environment_variables        = merge(try(container.value.environment_variables, null), try(local.environment_variables_from_resources[container.key], null))
      secure_environment_variables = try(container.value.secure_environment_variables, null)
      commands                     = try(container.value.commands, null)

      dynamic "gpu" {
        for_each = try(container.value.gpu, null) == null ? [] : [1]

        content {
          count = gpu.value.count
          sku   = gpu.value.sku
        }
      }

      dynamic "ports" {
        for_each = try(container.value.ports, {})

        content {
          port     = can(container.value.iterator) ? tonumber(ports.value.port) + container.value.iterator : ports.value.port
          protocol = try(upper(ports.value.protocol), "TCP")
        }
      }

      dynamic "readiness_probe" {
        for_each = try(container.value.readiness_probe, null) == null ? [] : [1]

        content {
          exec                  = try(readiness_probe.value.exec, null)
          initial_delay_seconds = try(readiness_probe.value.initial_delay_seconds, null)
          period_seconds        = try(readiness_probe.value.period_seconds, 10)
          failure_threshold     = try(readiness_probe.value.failure_threshold, 3)
          success_threshold     = try(readiness_probe.value.success_threshold, 1)
          timeout_seconds       = try(readiness_probe.value.timeout_seconds, 1)

          dynamic "http_get" {
            for_each = try(readiness_probe.value.http_get, {}) == {} ? [] : [1]

            content {
              path   = try(http_get.value.path, null)
              port   = try(http_get.value.port, null)
              scheme = try(http_get.value.scheme, null)
            }
          } //http_get
        }   //readiness_probe_content
      }     //readiness_probe

      dynamic "liveness_probe" {
        for_each = try(container.value.liveness_probe, null) == null ? [] : [1]

        content {
          exec                  = try(liveness_probe.value.exec, null)
          initial_delay_seconds = try(liveness_probe.value.initial_delay_seconds, null)
          period_seconds        = try(liveness_probe.value.period_seconds, 10)
          failure_threshold     = try(liveness_probe.value.failure_threshold, 3)
          success_threshold     = try(liveness_probe.value.success_threshold, 1)
          timeout_seconds       = try(liveness_probe.value.timeout_seconds, 1)

          dynamic "http_get" {
            for_each = try(liveness_probe.value.http_get, {}) == {} ? [] : [1]

            content {
              path   = try(http_get.value.path, null)
              port   = try(http_get.value.port, null)
              scheme = try(http_get.value.scheme, null)
            }
          } //http_get
        }
      } //liveness_probe

      dynamic "volume" {
        for_each = try(container.value.volume, null) == null ? [] : [1]

        content {
          name                 = volume.value.name
          mount_path           = volume.value.mount_path
          read_only            = try(volume.value.read_only, false)
          empty_dir            = try(volume.value.empty_dir, false)
          storage_account_name = try(volume.value.storage_account_name, null)
          storage_account_key  = try(volume.value.storage_account_key, null)
          share_name           = try(volume.value.share_name, null)
          secret               = try(volume.share.secret, null)

          dynamic "git_repo" {
            for_each = try(volume.value.git_repo, null) == null ? [] : [1]

            content {
              url       = git_repo.value.url
              directory = try(git_repo.value.directory, null)
              revision  = try(git_repo.value.revision, null)
            }
          } // git_repo
        }
      } // volume
    }   //container_content
  }     //container

  dynamic "identity" {
    for_each = try(var.settings.identity, false) == false ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "dns_config" {
    for_each = try(var.settings.dns_config, false) == false ? [] : [1]

    content {
      nameservers    = var.settings.dns_config.nameservers
      search_domains = try(var.settings.dns_config.search_domains, null)
      options        = try(var.settings.dns_config.options, null)
    }
  }

  dynamic "image_registry_credential" {
    for_each = try(var.settings.image_registry_credentials, {})
    content {
      server   = image_registry_credential.value.server
      username = try(data.azurerm_key_vault_secret.image_registry_credential_username[image_registry_credential.key].value, image_registry_credential.value.username)
      password = try(data.azurerm_key_vault_secret.image_registry_credential_password[image_registry_credential.key].value, image_registry_credential.value.password)
    }
  }

  # dynamic "diagnostics" {
  #   for_each = try(var.settings.diagnostics, false) == false ? [] : [1]

  #   content {
  #     log_analytics {

  #     }
  #   }
  # }
}
