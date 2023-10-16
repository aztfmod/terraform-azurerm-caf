resource "azurecaf_name" "wvdsp" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_desktop_scaling_plan"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_desktop_scaling_plan" "wvdsp" {
  description         = try(var.settings.description, null)
  exclusion_tag       = try(var.settings.exclusion_tag, null)
  friendly_name       = try(var.settings.friendly_name, null)
  location            = local.location
  name                = azurecaf_name.wvdsp.result
  resource_group_name = local.resource_group_name
  time_zone           = try(var.settings.time_zone, null)
  tags                = merge(local.tags, try(var.settings.tags, null))

  dynamic "schedule" {
    for_each = each.value.schedule

    content {
      days_of_week                         = schedule.value.days_of_week
      name                                 = schedule.value.name
      off_peak_load_balancing_algorithm    = schedule.value.off_peak_load_balancing_algorithm
      off_peak_start_time                  = schedule.value.off_peak_start_time
      peak_load_balancing_algorithm        = schedule.value.peak_load_balancing_algorithm
      peak_start_time                      = schedule.value.peak_start_time
      ramp_down_capacity_threshold_percent = schedule.value.ramp_down_capacity_threshold_percent
      ramp_down_force_logoff_users         = schedule.value.ramp_down_force_logoff_users
      ramp_down_load_balancing_algorithm   = schedule.value.ramp_down_load_balancing_algorithm
      ramp_down_minimum_hosts_percent      = schedule.value.ramp_down_minimum_hosts_percent
      ramp_down_notification_message       = schedule.value.ramp_down_notification_message
      ramp_down_start_time                 = schedule.value.ramp_down_start_time
      ramp_down_stop_hosts_when            = schedule.value.ramp_down_stop_hosts_when
      ramp_down_wait_time_minutes          = schedule.value.ramp_down_wait_time_minutes
      ramp_up_capacity_threshold_percent   = schedule.value.ramp_up_capacity_threshold_percent
      ramp_up_load_balancing_algorithm     = schedule.value.ramp_up_load_balancing_algorithm
      ramp_up_minimum_hosts_percent        = schedule.value.ramp_up_minimum_hosts_percent
      ramp_up_start_time                   = schedule.value.ramp_up_start_time
    }
  }

  dynamic "host_pool" {
    for_each = each.value.host_pool

    content {
      hostpool_id          = host_pool.value.vdpool_id
      scaling_plan_enabled = host_pool.value.enabled
    }
  }
}
