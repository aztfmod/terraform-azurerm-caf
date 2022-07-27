module "dynamic_keyvault_certificates" {
  # source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_certificates"
  source = "../modules/security/dynamic_keyvault_certificates"

  # source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/security/dynamic_keyvault_certificates?ref=master"

  for_each = {
    for keyvault_key, secrets in try(var.dynamic_keyvault_certificates, {}) : keyvault_key => {
      for key, value in secrets : key => value
      if try(value.contents, null) == null
    }
  }

  settings = each.value
  keyvault = module.example.keyvaults[each.key]
  objects  = module.example
}
