# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_firewall_rule" "redis_firewall_rule" {
  for_each = var.redis_firewall_rules == null ? {} : var.redis_firewall_rules

  name                = coalesce(each.value.name, each.key)
  redis_cache_name    = azurerm_redis_cache.redis.name
  resource_group_name = var.resource_group_name
  start_ip            = each.value.start_ip
  end_ip              = each.value.end_ip
}
