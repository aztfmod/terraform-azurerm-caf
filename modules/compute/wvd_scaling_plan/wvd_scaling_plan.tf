resource "azurerm_virtual_desktop_scaling_plan" "wvdsp" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  friendly_name       = try(var.settings.friendly_name, null)
  description         = try(var.settings.description, null)
  time_zone           = var.settings.time_zone

  dynamic "schedule" {
    for_each = var.settings.schedule
    content {
      name                                 = schedule.value.name
      days_of_week                         = schedule.value.days_of_week
      ramp_up_start_time                   = schedule.value.ramp_up_start_time
      ramp_up_load_balancing_algorithm     = schedule.value.ramp_up_load_balancing_algorithm
      ramp_up_minimum_hosts_percent        = schedule.value.ramp_up_minimum_hosts_percent
      ramp_up_capacity_threshold_percent   = schedule.value.ramp_up_capacity_threshold_percent
      peak_start_time                      = schedule.value.peak_start_time
      peak_load_balancing_algorithm        = schedule.value.peak_load_balancing_algorithm
      ramp_down_start_time                 = schedule.value.ramp_down_start_time
      ramp_down_load_balancing_algorithm   = schedule.value.ramp_down_load_balancing_algorithm
      ramp_down_minimum_hosts_percent      = schedule.value.ramp_down_minimum_hosts_percent
      ramp_down_force_logoff_users         = schedule.value.ramp_down_force_logoff_users
      ramp_down_wait_time_minutes          = schedule.value.ramp_down_wait_time_minutes
      ramp_down_notification_message       = schedule.value.ramp_down_notification_message
      ramp_down_capacity_threshold_percent = schedule.value.ramp_down_capacity_threshold_percent
      ramp_down_stop_hosts_when            = schedule.value.ramp_down_stop_hosts_when
      off_peak_start_time                  = schedule.value.off_peak_start_time
      off_peak_load_balancing_algorithm    = schedule.value.off_peak_load_balancing_algorithm
    }
  }
  dynamic "host_pool" {
    for_each = try(var.settings.host_pool, {})
    content {
      hostpool_id          = var.remote_objects.wvd_host_pools[try(var.client_config.landingzone_key, host_pool.value.lz_key)][host_pool.value.key].id
      scaling_plan_enabled = host_pool.value.scaling_plan_enabled
    }
  }
}