resource "azapi_resource" "invoice_section" {
  type                   = "Microsoft.Billing/billingAccounts/billingProfiles/invoiceSections@2020-05-01"
  name                   = var.settings.name
  parent_id              = format("/providers/Microsoft.Billing/billingAccounts/%s/billingProfiles/%s", var.settings.billing_account_id, var.settings.billing_profile_id)
  response_export_values = ["properties.displayName"]
  body = jsonencode({
    properties = {
      displayName = var.settings.name
      labels      = try(var.settings.labels, null)
      tags        = local.tags
    }
  })
}

output "id" {
  value = azapi_resource.invoice_section.id
}
output "name" {
  value = var.settings.name
}
output "display_name" {
  value = jsondecode(azapi_resource.invoice_section.output).properties.displayName
}
output "billing_account_id" {
  value = var.settings.billing_account_id
}
output "billing_profile_id" {
  value = var.settings.billing_profile_id
}
