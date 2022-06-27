resource "azapi_resource" "sfuc" {
  type      = "Microsoft.Automation/automationAccounts/softwareUpdateConfigurations@2019-06-01"
  name      = "myConfig"
  parent_id = var.automation_account_id

  body = jsonencode(var.settings.update_config)
}

