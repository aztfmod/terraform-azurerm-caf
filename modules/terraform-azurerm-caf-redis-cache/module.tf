
resource "azurecaf_naming_convention" "redis" {
  name          = var.redis.name
  prefix        = var.global_settings.prefix
  resource_type = "generic"
  convention    = var.global_settings.convention
  max_length    = var.global_settings.max_length
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "redis" {
  name                = azurecaf_naming_convention.redis.result
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.redis.capacity
  family              = var.redis.family
  sku_name            = var.redis.sku_name
  tags                = local.tags

  enable_non_ssl_port       = lookup(var.redis, "enable_non_ssl_port", null)
  minimum_tls_version       = lookup(var.redis, "minimum_tls_version", null)
  private_static_ip_address = lookup(var.redis, "private_static_ip_address", null)
  shard_count               = lookup(var.redis, "shard_count", null)
  subnet_id                 = lookup(var.redis, "subnet_id", null)
  zones                     = lookup(var.redis, "zones", null)

  dynamic "redis_configuration" {
    for_each = lookup(var.redis, "redis_configuration", {}) != {} ? [var.redis.redis_configuration] : []

    content {
      enable_authentication           = lookup(redis_configuration.value, "enable_authentication", null)
      maxmemory_reserved              = lookup(redis_configuration.value, "maxmemory_reserved", null)
      maxmemory_delta                 = lookup(redis_configuration.value, "maxmemory_delta", null)
      maxmemory_policy                = lookup(redis_configuration.value, "maxmemory_policy", null)
      maxfragmentationmemory_reserved = lookup(redis_configuration.value, "maxfragmentationmemory_reserved", null)
      rdb_backup_enabled              = lookup(redis_configuration.value, "rdb_backup_enabled", null)
      rdb_backup_frequency            = lookup(redis_configuration.value, "rdb_backup_frequency", null)
      rdb_backup_max_snapshot_count   = lookup(redis_configuration.value, "rdb_backup_max_snapshot_count", null)
      rdb_storage_connection_string   = lookup(redis_configuration.value, "rdb_storage_connection_string", null)
      notify_keyspace_events          = lookup(redis_configuration.value, "notify_keyspace_events", null)
    }
  }

  dynamic "patch_schedule" {
    for_each = lookup(var.redis, "patch_schedule", {}) != {} ? [var.redis.patch_schedule] : []

    content {
      day_of_week    = patch_schedule.value.day_of_week
      start_hour_utc = lookup(patch_schedule.value, "start_hour_utc", null)
    }
  }
}

