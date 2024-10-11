module "security_center_subscription_pricings" {
  source   = "./modules/security/security_center/subscription_pricing"
  for_each = try(local.security.security_center_subscription_pricings, {})

  tier          = each.value.tier
  subplan       = try(each.value.subplan, null)
  resource_type = each.value.resource_type
  extensions    = try(each.value.extensions, null)
}
