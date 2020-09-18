# scheduler examples
resource "azurerm_automation_schedule" "sched_one_time" {
  name                    = "${var.name}-one-time"
  resource_group_name     = azurerm_automation_account.auto_account.resource_group_name
  automation_account_name = azurerm_automation_account.auto_account.name
  frequency               = "OneTime"

  // The start_time defaults to now + 7 min
}

resource "azurerm_automation_schedule" "sched_hour" {
  name                    = "${var.name}-hour"
  resource_group_name     = azurerm_automation_account.auto_account.resource_group_name
  automation_account_name = azurerm_automation_account.auto_account.name
  frequency               = "Hour"
  interval                = 2

  // Timezone defaults to UTC
}