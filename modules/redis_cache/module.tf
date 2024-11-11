
resource "azurecaf_name" "redis" {

  name          = var.redis.name
  resource_type = "azurerm_redis_cache"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "redis" {
  name                = azurecaf_name.redis.result
  location            = local.location
  resource_group_name = local.resource_group_name
  capacity            = var.redis.capacity
  family              = var.redis.family
  sku_name            = var.redis.sku_name
  tags                = merge(local.tags, try(var.tags, null))

  non_ssl_port_enabled          = lookup(var.redis, "non_ssl_port_enabled", null)
  minimum_tls_version           = lookup(var.redis, "minimum_tls_version", "1.2")
  private_static_ip_address     = lookup(var.redis, "private_static_ip_address", null)
  public_network_access_enabled = lookup(var.redis, "public_network_access_enabled", null)
  shard_count                   = lookup(var.redis, "shard_count", null)
  replicas_per_master           = lookup(var.redis, "replicas_per_master", null)
  replicas_per_primary          = lookup(var.redis, "replicas_per_primary", null)
  zones                         = lookup(var.redis, "zones", null)
  redis_version                 = lookup(var.redis, "redis_version", null)
  subnet_id                     = try(var.subnet_id, null)

  dynamic "redis_configuration" {
    for_each = lookup(var.redis, "redis_configuration", {}) != {} ? [var.redis.redis_configuration] : []

    content {
      aof_backup_enabled              = lookup(redis_configuration.value, "aof_backup_enabled", null)
      aof_storage_connection_string_0 = lookup(redis_configuration.value, "aof_storage_connection_string_0", null)
      aof_storage_connection_string_1 = lookup(redis_configuration.value, "aof_storage_connection_string_1", null)
      authentication_enabled          = lookup(redis_configuration.value, "authentication_enabled", null)
      maxfragmentationmemory_reserved = lookup(redis_configuration.value, "maxfragmentationmemory_reserved", null)
      maxmemory_delta                 = lookup(redis_configuration.value, "maxmemory_delta", null)
      maxmemory_policy                = lookup(redis_configuration.value, "maxmemory_policy", null)
      maxmemory_reserved              = lookup(redis_configuration.value, "maxmemory_reserved", null)
      notify_keyspace_events          = lookup(redis_configuration.value, "notify_keyspace_events", null)
      rdb_backup_enabled              = lookup(redis_configuration.value, "rdb_backup_enabled", null)
      rdb_backup_frequency            = lookup(redis_configuration.value, "rdb_backup_frequency", null)
      rdb_backup_max_snapshot_count   = lookup(redis_configuration.value, "rdb_backup_max_snapshot_count", null)
      rdb_storage_connection_string   = lookup(redis_configuration.value, "rdb_storage_connection_string", null)
    }
  }

  dynamic "identity" {
    for_each = can(var.redis.identity) ? [var.redis.identity] : []

    content {
      type         = identity.value.type
      identity_ids = local.managed_identities
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
