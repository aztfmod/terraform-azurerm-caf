module "dynamic_keyvault_certificates" {
  # source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_certificates"
  source = "../modules/security/dynamic_keyvault_certificates"

  # source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/security/dynamic_keyvault_certificates?ref=master"
  for_each = try(var.dynamic_keyvault_certificates, {})

  settings = each.value
  keyvault = module.example.keyvaults[each.key]
  objects  = module.example
}
