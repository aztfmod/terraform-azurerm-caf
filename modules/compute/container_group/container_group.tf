resource "azurecaf_name" "acg" {
  name          = var.settings.name
  resource_type = "azurerm_containerGroups"
  prefixes      = var.global_settings.prefixes
  suffixes      = var.global_settings.suffixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_container_group" "acg" {
  name                = azurecaf_name.acg.result
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.settings.os_type
  dns_name_label      = try(var.settings.dns_name_label, null)
  tags                = merge(local.tags, try(var.settings.tags, null))
  ip_address_type     = try(var.settings.ip_address_type, "Public")
  restart_policy      = try(var.settings.restart_policy, "Always")

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
          port     = ports.value.port
          protocol = ports.value.protocol
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
      search_domains = var.settings.dns_config.search_domains
      options        = var.settings.dns_config.options
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
