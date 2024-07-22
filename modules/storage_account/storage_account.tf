locals {
  # Need to update the storage tags if the environment tag is updated with the rover command line
  caf_tags = can(var.storage_account.tags.caf_environment) || can(var.storage_account.tags.environment) ? merge(lookup(var.storage_account, "tags", {}), { "caf_environment" : var.global_settings.environment }) : {}
}

# naming convention
resource "azurecaf_name" "stg" {
  name          = var.storage_account.name
  resource_type = "azurerm_storage_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

resource "azurerm_storage_account" "stg" {
  name                              = azurecaf_name.stg.result
  account_tier                      = try(var.storage_account.account_tier, "Standard")
  account_replication_type          = try(var.storage_account.account_replication_type, "LRS")
  account_kind                      = try(var.storage_account.account_kind, "StorageV2")
  access_tier                       = contains(["BlobStorage", "FileStorage", "StorageV2"], try(var.storage_account.account_kind, "StorageV2")) ? try(var.storage_account.access_tier, "Hot") : null
  allow_nested_items_to_be_public   = try(var.storage_account.allow_nested_items_to_be_public, var.storage_account.allow_blob_public_access, false)
  cross_tenant_replication_enabled  = try(var.storage_account.cross_tenant_replication_enabled, null)
  edge_zone                         = try(var.storage_account.edge_zone, null)
  enable_https_traffic_only         = try(var.storage_account.enable_https_traffic_only, true)
  infrastructure_encryption_enabled = try(var.storage_account.infrastructure_encryption_enabled, null)
  large_file_share_enabled          = try(var.storage_account.large_file_share_enabled, null)
  location                          = local.location
  min_tls_version                   = try(var.storage_account.min_tls_version, "TLS1_2")
  is_hns_enabled                    = try(var.storage_account.is_hns_enabled, false)
  sftp_enabled                      = try(var.storage_account.sftp_enabled, null)
  nfsv3_enabled                     = try(var.storage_account.nfsv3_enabled, false)
  queue_encryption_key_type         = try(var.storage_account.queue_encryption_key_type, null)
  resource_group_name               = local.resource_group_name
  table_encryption_key_type         = try(var.storage_account.table_encryption_key_type, null)
  tags                              = merge(local.tags, try(var.storage_account.tags, null), local.caf_tags)
  public_network_access_enabled     = try(var.storage_account.public_network_access_enabled, null)


  dynamic "custom_domain" {
    for_each = lookup(var.storage_account, "custom_domain", false) == false ? [] : [1]

    content {
      name          = var.storage_account.custom_domain.name
      use_subdomain = try(var.storage_account.custom_domain.use_subdomain, null)
    }
  }

  dynamic "identity" {
    for_each = lookup(var.storage_account, "enable_system_msi", false) == false ? [] : [1]

    content {
      type = "SystemAssigned"
    }
  }

  dynamic "identity" {
    for_each = can(var.storage_account.identity) ? [var.storage_account.identity] : []

    content {
      type         = identity.value.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "blob_properties" {
    for_each = lookup(var.storage_account, "blob_properties", false) == false ? [] : [1]

    content {
      versioning_enabled       = try(var.storage_account.blob_properties.versioning_enabled, false)
      change_feed_enabled      = try(var.storage_account.blob_properties.change_feed_enabled, false)
      default_service_version  = try(var.storage_account.blob_properties.default_service_version, "2020-06-12")
      last_access_time_enabled = try(var.storage_account.blob_properties.last_access_time_enabled, false)

      dynamic "cors_rule" {
        for_each = lookup(var.storage_account.blob_properties, "cors_rule", false) == false ? [] : [1]

        content {
          allowed_headers    = var.storage_account.blob_properties.cors_rule.allowed_headers
          allowed_methods    = var.storage_account.blob_properties.cors_rule.allowed_methods
          allowed_origins    = var.storage_account.blob_properties.cors_rule.allowed_origins
          exposed_headers    = var.storage_account.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.storage_account.blob_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = lookup(var.storage_account.blob_properties, "delete_retention_policy", false) == false ? [] : [1]

        content {
          days = try(var.storage_account.blob_properties.delete_retention_policy.delete_retention_policy, 7)
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = lookup(var.storage_account.blob_properties, "container_delete_retention_policy", false) == false ? [] : [1]

        content {
          days = try(var.storage_account.blob_properties.container_delete_retention_policy.container_delete_retention_policy, 7)
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = lookup(var.storage_account, "queue_properties", false) == false ? [] : [1]

    content {
      dynamic "cors_rule" {
        for_each = lookup(var.storage_account.queue_properties, "cors_rule", false) == false ? [] : [1]

        content {
          allowed_headers    = var.storage_account.queue_properties.cors_rule.allowed_headers
          allowed_methods    = var.storage_account.queue_properties.cors_rule.allowed_methods
          allowed_origins    = var.storage_account.queue_properties.cors_rule.allowed_origins
          exposed_headers    = var.storage_account.queue_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.storage_account.queue_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "logging" {
        for_each = lookup(var.storage_account.queue_properties, "logging", false) == false ? [] : [1]

        content {
          delete                = var.storage_account.queue_properties.logging.delete
          read                  = var.storage_account.queue_properties.logging.read
          write                 = var.storage_account.queue_properties.logging.write
          version               = var.storage_account.queue_properties.logging.version
          retention_policy_days = try(var.storage_account.queue_properties.logging.retention_policy_days, 7)
        }
      }

      dynamic "minute_metrics" {
        for_each = lookup(var.storage_account.queue_properties, "minute_metrics", false) == false ? [] : [1]

        content {
          enabled               = var.storage_account.queue_properties.minute_metrics.enabled
          version               = var.storage_account.queue_properties.minute_metrics.version
          include_apis          = try(var.storage_account.queue_properties.minute_metrics.include_apis, null)
          retention_policy_days = try(var.storage_account.queue_properties.minute_metrics.retention_policy_days, 7)
        }
      }

      dynamic "hour_metrics" {
        for_each = lookup(var.storage_account.queue_properties, "hour_metrics", false) == false ? [] : [1]

        content {
          enabled               = var.storage_account.queue_properties.hour_metrics.enabled
          version               = var.storage_account.queue_properties.hour_metrics.version
          include_apis          = try(var.storage_account.queue_properties.hour_metrics.include_apis, null)
          retention_policy_days = try(var.storage_account.queue_properties.hour_metrics.retention_policy_days, 7)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = lookup(var.storage_account, "static_website", false) == false ? [] : [1]

    content {
      index_document     = try(var.storage_account.static_website.index_document, null)
      error_404_document = try(var.storage_account.static_website.error_404_document, null)
    }
  }

  dynamic "network_rules" {
    for_each = lookup(var.storage_account, "network", null) == null ? [] : [1]
    content {
      bypass         = try(var.storage_account.network.bypass, [])
      default_action = try(var.storage_account.network.default_action, "Deny")
      ip_rules       = try(var.storage_account.network.ip_rules, [])
      virtual_network_subnet_ids = try(var.storage_account.network.subnets, null) == null ? null : [
        for key, value in var.storage_account.network.subnets : can(value.remote_subnet_id) ? value.remote_subnet_id : var.vnets[try(value.lz_key, var.client_config.landingzone_key)][value.vnet_key].subnets[value.subnet_key].id
      ]
    }
  }

  dynamic "azure_files_authentication" {
    for_each = lookup(var.storage_account, "azure_files_authentication", false) == false ? [] : [1]

    content {
      directory_type = var.storage_account.azure_files_authentication.directory_type

      dynamic "active_directory" {
        for_each = lookup(var.storage_account.azure_files_authentication, "active_directory", false) == false ? [] : [1]

        content {
          storage_sid         = var.storage_account.azure_files_authentication.active_directory.storage_sid
          domain_name         = var.storage_account.azure_files_authentication.active_directory.domain_name
          domain_sid          = var.storage_account.azure_files_authentication.active_directory.domain_sid
          domain_guid         = var.storage_account.azure_files_authentication.active_directory.domain_guid
          forest_name         = var.storage_account.azure_files_authentication.active_directory.forest_name
          netbios_domain_name = var.storage_account.azure_files_authentication.active_directory.netbios_domain_name
        }
      }
    }
  }

  dynamic "routing" {
    for_each = lookup(var.storage_account, "routing", false) == false ? [] : [1]

    content {
      publish_internet_endpoints  = try(var.storage_account.routing.publish_internet_endpoints, false)
      publish_microsoft_endpoints = try(var.storage_account.routing.publish_microsoft_endpoints, false)
      choice                      = try(var.storage_account.routing.choice, "MicrosoftRouting")
    }
  }

  dynamic "share_properties" {
    for_each = can(var.storage_account.share_properties) ? [1] : []

    content {
      dynamic "cors_rule" {
        for_each = can(var.storage_account.share_properties.cors_rule) ? [1] : []

        content {
          allowed_headers    = var.storage_account.share_properties.cors_rule.allowed_headers
          allowed_methods    = var.storage_account.share_properties.cors_rule.allowed_methods
          allowed_origins    = var.storage_account.share_properties.cors_rule.allowed_origins
          exposed_headers    = var.storage_account.share_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.storage_account.share_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "retention_policy" {
        for_each = can(var.storage_account.share_properties.retention_policy) ? [1] : []

        content {
          days = try(var.storage_account.share_properties.retention_policy.days, 7)
        }
      }

      dynamic "smb" {
        for_each = can(var.storage_account.share_properties.smb) ? [1] : []

        content {
          versions                        = try(var.storage_account.share_properties.smb.versions, null)
          authentication_types            = try(var.storage_account.share_properties.smb.authentication_types, null)
          kerberos_ticket_encryption_type = try(var.storage_account.share_properties.smb.kerberos_ticket_encryption_type, null)
          channel_encryption_type         = try(var.storage_account.share_properties.smb.channel_encryption_type, null)
        }
      }

    }
  }

  lifecycle {
    ignore_changes = [
      location, resource_group_name
    ]
  }
}

module "queue" {
  source   = "./queue"
  for_each = try(var.storage_account.queues, {})

  storage_account_name = azurerm_storage_account.stg.name
  settings             = each.value
}

module "container" {
  source   = "./container"
  for_each = try(var.storage_account.containers, {})

  storage_account_name = azurerm_storage_account.stg.name
  settings             = each.value
  var_folder_path      = var.var_folder_path
}

module "data_lake_filesystem" {
  source   = "./data_lake_filesystem"
  for_each = try(var.storage_account.data_lake_filesystems, {})

  storage_account_id = azurerm_storage_account.stg.id
  settings           = each.value
}

module "file_share" {
  source     = "./file_share"
  for_each   = try(var.storage_account.file_shares, {})
  depends_on = [azurerm_backup_container_storage_account.container]

  storage_account_name = azurerm_storage_account.stg.name
  storage_account_id   = azurerm_storage_account.stg.id
  settings             = each.value
  recovery_vault       = local.recovery_vault
  resource_group_name  = local.resource_group_name
}

module "management_policy" {
  source             = "./management_policy"
  for_each           = try(var.storage_account.management_policies, {})
  storage_account_id = azurerm_storage_account.stg.id
  settings           = try(var.storage_account.management_policies, {})
}
