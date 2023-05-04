# Create log analytics workspace with Updates solution and linked automation account
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "basic"
    resource_group_key = "automation"
  }
}

diagnostic_log_analytics = {
  region1 = {
    region             = "region1"
    name               = "logre1"
    resource_group_key = "automation"
  }
}

automation_log_analytics_links = {
  link1 = {
    workspace_key          = "region1"
    automation_account_key = "auto1"
    resource_group_key     = "automation"
  }
}