resource "azurecaf_name" "pool" {
  name          = var.settings.name
  resource_type = "azurerm_batch_pool"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_batch_pool" "pool" {
  name                = azurecaf_name.pool.result
  account_name        = var.batch_account.name
  resource_group_name = var.batch_account.resource_group_name
  node_agent_sku_id   = var.settings.node_agent_sku_id
  vm_size             = var.settings.vm_size
  display_name        = try(var.settings.display_name, null)
  max_tasks_per_node  = try(var.settings.max_tasks_per_node, null)
  metadata            = try(var.settings.metadata, {})

  storage_image_reference {
    publisher = var.settings.storage_image_reference.publisher
    offer     = var.settings.storage_image_reference.offer
    sku       = var.settings.storage_image_reference.sku
    version   = try(var.settings.storage_image_reference.version, null)
  }

  dynamic "identity" {
    for_each = try(var.settings.identity, null) != null ? [var.settings.identity] : []

    content {
      type         = identity.value.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "fixed_scale" {
    for_each = try(var.settings.fixed_scale, null) != null ? [var.settings.fixed_scale] : []

    content {
      target_dedicated_nodes    = try(fixed_scale.value.target_dedicated_nodes, null)
      target_low_priority_nodes = try(fixed_scale.value.target_low_priority_nodes, null)
      resize_timeout            = try(fixed_scale.value.resize_timeout, null)
    }
  }

  dynamic "auto_scale" {
    for_each = try(var.settings.auto_scale, null) != null ? [var.settings.auto_scale] : []

    content {
      evaluation_interval = try(auto_scale.value.evaluation_interval, null)
      formula             = auto_scale.value.formula
    }
  }

  dynamic "start_task" {
    for_each = try(var.settings.start_task, null) != null ? [var.settings.start_task] : []

    content {
      command_line                  = start_task.value.command_line
      task_retry_maximum            = try(start_task.value.task_retry_maximum, null)
      wait_for_success              = try(start_task.value.wait_for_success, null)
      common_environment_properties = try(start_task.value.common_environment_properties, null)

      user_identity {
        user_name = try(start_task.value.user_identity.user_name, null)

        dynamic "auto_user" {
          for_each = try(start_task.value.user_identity.auto_user, null) != null ? [start_task.value.user_identity.auto_user] : []

          content {
            elevation_level = try(auto_user.value.elevation_level, null)
            scope           = try(auto_user.value.scope, null)
          }
        }
      }

      dynamic "resource_file" {
        for_each = try(start_task.value.resource_files, {})

        content {
          auto_storage_container_name = try(resource_file.value.auto_storage_container_name, null)
          blob_prefix                 = try(resource_file.value.blob_prefix, null)
          file_mode                   = try(resource_file.value.file_mode, null)
          file_path                   = try(resource_file.value.file_path, null)
          http_url                    = try(resource_file.value.http_url, null)
          storage_container_url       = try(resource_file.value.storage_container_url, null)
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = try(var.settings.certificates, {})

    content {
      id             = var.batch_certificates[try(certificate.value.lz_key, var.client_config.landingzone_key)][certificate.value.certificate_key].id
      store_location = certificate.value.store_location
      store_name     = try(certificate.value.store_name, null)
      visibility     = try(certificate.value.visibility, null)
    }
  }

  dynamic "container_configuration" {
    for_each = try(var.settings.container_configuration, null) != null ? [var.settings.container_configuration] : []

    content {
      type                  = try(container_configuration.value.type, null)
      container_image_names = try(container_configuration.value.container_image_names, null)

      dynamic "container_registries" {
        for_each = try(container_configuration.value.container_registries, null) != null ? [container_configuration.value.container_registries] : []

        content {
          registry_server = try(container_registries.value.registry_server, null)
          user_name       = try(container_registries.value.user_name, null)
          password        = try(container_registries.value.password, null)
        }
      }
    }
  }

  dynamic "network_configuration" {
    for_each = try(var.settings.network_configuration, null) != null ? [var.settings.network_configuration] : []

    content {
      subnet_id                        = var.vnets[try(network_configuration.value.vnet.lz_key, var.client_config.landingzone_key)][try(network_configuration.value.vnet.vnet_key, network_configuration.value.vnet_key)].subnets[try(network_configuration.value.vnet.subnet_key, network_configuration.value.subnet_key)].id
      public_ips                       = try(network_configuration.value.public_ips, null)
      public_address_provisioning_type = try(network_configuration.value.public_address_provisioning_type, null)

      dynamic "endpoint_configuration" {
        for_each = try(network_configuration.value.endpoint_configuration, null) != null ? [network_configuration.value.endpoint_configuration] : []

        content {
          name                = endpoint_configuration.value.name
          backend_port        = endpoint_configuration.value.backend_port
          protocol            = endpoint_configuration.value.protocol
          frontend_port_range = endpoint_configuration.value.frontend_port_range

          dynamic "network_security_group_rules" {
            for_each = try(endpoint_configuration.value.network_security_group_rules, null) != null ? [endpoint_configuration.value.network_security_group_rules] : []

            content {
              access                = network_security_group_rules.value.access
              priority              = network_security_group_rules.value.priority
              source_address_prefix = network_security_group_rules.value.source_address_prefix
            }
          }
        }
      }
    }
  }
}
