
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    example = "examples/automation/104-automation-schedule-runbook"
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
    sku                = "Basic"
    resource_group_key = "automation"
  }
}

automation_runbooks = {
  runbook1 = {
    name                   = "Get-AzureVMTutorial"
    resource_group_key     = "automation"
    automation_account_key = "auto1"
    log_verbose            = "true"
    log_progress           = "true"
    description            = "This is an example runbook"
    runbook_type           = "PowerShellWorkflow"
    publish_content_link = {
      uri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/c4935ffb69246a6058eb24f54640f53f69d3ac9f/101-automation-runbook-getvms/Runbooks/Get-AzureVMTutorial.ps1"
    }
    tags = {
      runbook = "example"
    }
  }
}

automation_schedules = {
  schedule1 = {
    name                   = "tfex-automation-schedule"
    resource_group_key     = "automation"
    automation_account_key = "auto1"
    frequency              = "Week"
    interval               = 1
    timezone               = "Australia/Perth"
    start_time             = "2025-04-15T18:00:15+02:00"
    description            = "This is an example schedule"
    week_days              = ["Friday"]
  }
}