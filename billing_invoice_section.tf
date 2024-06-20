module "invoice_section" {
  source     = "./modules/billing/invoice_sections"
  for_each   = var.invoice_sections

    global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
    base_tags = local.global_settings.inherit_tags
}

output "invoice_sections" {
  value = module.invoice_section
}