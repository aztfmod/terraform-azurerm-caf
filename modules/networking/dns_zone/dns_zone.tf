resource "azurerm_dns_zone" "domain_zone" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_template_deployment" "domain" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  template_body       = file(local.arm_filename)
  lifecycle {
    ignore_changes = [parameters]
  }
  parameters = {
    "Name"          = var.settings.name 
    "key1"          = lookup(var.settings.contract, "agreement_key1", "DNRA"),
    "key2"          = lookup(var.settings.contract, "agreement_key2", "DNRA"),
    "AgreedBy"      = lookup(var.settings.contract, "agree_by", "100.5.150.200:52212"), #Change to DevOps Agent IP
    "AgreedAt"      = timestamp(),
    "Address1"      = lookup(var.settings.contract, "address1", ""),
    "Address2"      = lookup(var.settings.contract, "address2", ""),
    "City"          = lookup(var.settings.contract, "city", ""),
    "Country"       = lookup(var.settings.contract, "country", ""),
    "PostalCode"    = lookup(var.settings.contract, "postal_code", ""),
    "State"         = lookup(var.settings.contract, "state", ""),
    "Email"         = lookup(var.settings.contract, "email", ""),
    "Fax"           = lookup(var.settings.contract, "fax", ""),
    "JobTitle"      = lookup(var.settings.contract, "job_title", ""),
    "NameFirst"     = lookup(var.settings.contract, "name_first", ""),
    "NameLast"      = lookup(var.settings.contract, "name_last", ""),
    "NameMiddle"    = lookup(var.settings.contract, "name_middle", ""),
    "Organization"  = lookup(var.settings.contract, "organization", ""),
    "Phone"         = lookup(var.settings.contract, "phone", ""),
    "autoRenew"     = lookup(var.settings.contract, "auto_renew", false),
    "targetDnsType" = lookup(var.settings.contract, "target_dnstype", "AzureDns"),
    "dnsZoneId"     = azurerm_dns_zone.domain_zone.id
  }

  deployment_mode = "Incremental"
  depends_on      = [azurerm_dns_zone.domain_zone]
}

resource "azurerm_management_lock" "lock_zone" {
  count      = var.lock_zone ? 1 : 0
  name       = "${var.settings.name}-lock-zone"
  scope      = azurerm_dns_zone.domain_zone.id
  lock_level = "CanNotDelete"
  notes      = "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
}

resource "azurerm_management_lock" "lock_domain" {
  count      = var.lock_domain ? 1 : 0
  name       = "${var.settings.name}-lock-domain"
  scope      = azurerm_template_deployment.domain.outputs.resourceID
  lock_level = "CanNotDelete"
  notes      = "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
}

resource "azurerm_dns_cname_record" "target" {
  name                = "target"
  zone_name           = azurerm_dns_zone.domain_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  record              = "forfrontdoor.azurefd.net"
}

# module "dns_records" {
#   # source = "terraformdns/dns-recordsets/azurerm"

#   resource_group_name = var.resource_group_name
#   dns_zone_name       = azurerm_dns_zone.domain_zone.name
#   recordsets = [
#     {
#       name    = "www"
#       type    = "A"
#       ttl     = 3600
#       records = [
#         "192.0.2.56",
#       ]
#     },
#     {
#       name    = ""
#       type    = "TXT"
#       ttl     = 3600
#       records = [
#         "\"v=spf1 ip4:192.0.2.3 include:backoff.${aws_route53_zone.example.name} -all\"",
#       ]
#     },
    
#   ]
# }


