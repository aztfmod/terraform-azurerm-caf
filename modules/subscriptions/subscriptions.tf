data "azurerm_billing_enrollment_account_scope" "sub" {
  count = try(var.settings.subscription_id, null) == null && var.subscription_key != "logged_in_subscription" ? 1 : 0

  billing_account_name    = var.settings.billing_account_name
  enrollment_account_name = var.settings.enrollment_account_name
}

resource "azurerm_subscription" "sub" {
  count = try(var.settings.subscription_id, null) == null && var.subscription_key != "logged_in_subscription" ? 1 : 0

  alias             = var.subscription_key
  subscription_name = var.settings.name
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.sub.0.id
  workload          = try(var.settings.workload, null)
}


resource "null_resource" "refresh_access_token" {
  depends_on = [azurerm_subscription.sub]

  count = try(var.settings.subscription_id, null) == null && var.subscription_key != "logged_in_subscription" ? 1 : 0

  triggers = {
    subscription_id = azurerm_subscription.sub.0.subscription_id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/refresh_access_token.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail
  }

}
