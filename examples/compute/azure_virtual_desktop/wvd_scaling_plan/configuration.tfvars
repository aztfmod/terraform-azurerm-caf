global_settings = {
  default_region = "region1"
  environment    = "test"
  inherit_tags   = true
  regions = {
    region1 = "westeurope"
    region2 = "nordeurope"
  }
}
resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  wvd_region1 = {
    name = "wvd-pre"
  }
}

wvd_host_pools = {
  wvd_hp1 = {
    resource_group_key   = "wvd_region1"
    name                 = "armhp"
    friendly_name        = "Myhostpool"
    description          = "A description of my workspace"
    validate_environment = false
    type                 = "Pooled"
    #Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications.
    preferred_app_group_type = "Desktop"
    maximum_sessions_allowed = 1000
    load_balancer_type       = "DepthFirst"
    #Expiration value should be between 1 hour and 30 days.
    registration_info = {
      token_validity = "720h" #in hours (30d)
    }
  }
  wvd_hp3 = {
    resource_group_key   = "wvd_region1"
    name                 = "pool3"
    friendly_name        = "Myhostpool3"
    description          = "A description of my workspace"
    validate_environment = false
    type                 = "Pooled"
    #Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications.
    preferred_app_group_type = "Desktop"
    maximum_sessions_allowed = 1000
    load_balancer_type       = "DepthFirst"
    #Expiration value should be between 1 hour and 30 days.
    registration_info = {
      token_validity = "720h" #in hours (30d)
    }
  }
}

wvd_scaling_plans = {
  sp01 = {
    name = "sp01"
    # friendly_name      = "Scaling Plan 01"
    # description        = "Scale plan for hostpool"
    time_zone          = "UTC"
    resource_group_key = "wvd_region1"
    schedule = {
      weekdays = {
        name                                 = "Weekdays"
        days_of_week                         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        ramp_up_start_time                   = "05:00"
        ramp_up_load_balancing_algorithm     = "BreadthFirst"
        ramp_up_minimum_hosts_percent        = 20
        ramp_up_capacity_threshold_percent   = 10
        peak_start_time                      = "09:00"
        peak_load_balancing_algorithm        = "BreadthFirst"
        ramp_down_start_time                 = "19:00"
        ramp_down_load_balancing_algorithm   = "DepthFirst"
        ramp_down_minimum_hosts_percent      = 10
        ramp_down_force_logoff_users         = false
        ramp_down_wait_time_minutes          = 45
        ramp_down_notification_message       = "Please log off in the next 45 minutes..."
        ramp_down_capacity_threshold_percent = 5
        ramp_down_stop_hosts_when            = "ZeroSessions"
        off_peak_start_time                  = "22:00"
        off_peak_load_balancing_algorithm    = "DepthFirst"
      }
      weekends = {
        name                                 = "Weekends"
        days_of_week                         = ["Saturday", "Sunday"]
        ramp_up_start_time                   = "09:00"
        ramp_up_load_balancing_algorithm     = "BreadthFirst"
        ramp_up_minimum_hosts_percent        = 5
        ramp_up_capacity_threshold_percent   = 2
        peak_start_time                      = "10:00"
        peak_load_balancing_algorithm        = "BreadthFirst"
        ramp_down_start_time                 = "13:00"
        ramp_down_load_balancing_algorithm   = "DepthFirst"
        ramp_down_minimum_hosts_percent      = 10
        ramp_down_force_logoff_users         = false
        ramp_down_wait_time_minutes          = 45
        ramp_down_notification_message       = "Please log off in the next 45 minutes..."
        ramp_down_capacity_threshold_percent = 5
        ramp_down_stop_hosts_when            = "ZeroSessions"
        off_peak_start_time                  = "14:00"
        off_peak_load_balancing_algorithm    = "DepthFirst"
      }
    }
    host_pool = {
      hostpool_1 = {
        key                  = "wvd_hp1"
        scaling_plan_enabled = true
      }
      hostpool = {
        key                  = "wvd_hp3"
        scaling_plan_enabled = true
      }
    }
  }
}