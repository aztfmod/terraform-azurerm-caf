
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

automation_job_schedules = {
  job_schedule_01 = {
    name                    = "jsched_runbook1_friday"
    resource_group_key      = "automation"
    automation_account_key  = "auto1"
    automation_schedule_key = "schedule1"
    automation_runbook_key  = "runbook1"
    parameters = {
      paRam1 = "value1"
      FOO    = 1
    }
  }
}