data "azurerm_billing_enrollment_account_scope" "sub" {
  count = try(var.settings.subscription_id, null) == null && var.subscription_key != "logged_in_subscription" && try(var.settings.enrollment_account_name, null) != null ? 1 : 0

  billing_account_name    = var.settings.billing_account_name
  enrollment_account_name = var.settings.enrollment_account_name
}

data "azurerm_billing_mca_account_scope" "sub" {
  count = !can(var.settings.subscription_id) && var.subscription_key != "logged_in_subscription" && can(var.settings.billing_profile_name) && !can(var.settings.invoice_section_key) ? 1 : 0

  billing_account_name = var.settings.billing_account_name
  billing_profile_name = var.settings.billing_profile_name
  invoice_section_name = var.settings.invoice_section_name
}

resource "azurerm_subscription" "sub" {
  count = var.subscription_key != "logged_in_subscription" && lookup(var.settings, "create_alias", true) ? 1 : 0

  alias             = try(var.settings.alias, null) == null ? var.subscription_key : var.settings.alias
  subscription_name = var.settings.name
  subscription_id   = try(var.settings.subscription_id, null) != null ? var.settings.subscription_id : null
  billing_scope_id  = can(local.billing_scope_id) ? local.billing_scope_id : try(data.azurerm_billing_enrollment_account_scope.sub.0.id, data.azurerm_billing_mca_account_scope.sub.0.id, null)

  workload = try(var.settings.workload, null)
  tags     = try(var.tags, null)

  lifecycle {
    ignore_changes = [
      workload
    ]
  }
}
locals {
  billing_scope_by_name = try(data.azurerm_billing_enrollment_account_scope.sub.0.id, data.azurerm_billing_mca_account_scope.sub.0.id, null)
  billing_scope_by_key = try((can(var.billing_scope_id) ? var.billing_scope_id : null), (can(var.settings.billing_scope_id) ? var.settings.billing_scope_id : null), null)
  billing_scope_id     = try(coalesce(local.billing_scope_by_name, local.billing_scope_by_key), null)
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
