global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

resource_groups = {
  rgwflow1 = {
    name   = "exampleRG1"
    region = "region1"
  }
}

logic_app_workflow = {
  applogic1 = {
    name               = "workflow1"
    region             = "region1"
    resource_group_key = "rgwflow1"
    #integration_service_environment_key
    #logic_app_integration_account_key
    #workflow_parameters
    #workflow_schema
    workflow_version = "1.0.0.0"
    #parameters
  }
}

logic_app_action_custom = {
  action_custom1 = {
    name          = "webhook"
    logic_app_key = "applogic1"
    body          = <<BODY
{
    "description": "A variable to configure the auto expiration age in days. Configured in negative number. Default is -30 (30 days old).",
    "inputs": {
        "variables": [
            {
                "name": "ExpirationAgeInDays",
                "type": "Integer",
                "value": -30
            }
        ]
    },
    "runAfter": {},
    "type": "InitializeVariable"
}
BODY
  }
}