module "security_center" {
  source         = "./modules/security/security_center/"
  for_each       = var.security_center
  auto_provision = each.value.auto_provision
}
