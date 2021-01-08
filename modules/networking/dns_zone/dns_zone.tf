resource "random_string" "domain_zone_name" {
  count   = var.settings.name == "" ? 1 : 0
  length  = 16
  special = false
  upper   = false
}

locals {
  domain_zone_name = var.settings.name == "" ? format("%s.com", random_string.domain_zone_name[0].result) : var.settings.name
}


resource "azurerm_dns_zone" "domain_zone" {
  name                = local.domain_zone_name
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

resource "azurerm_template_deployment" "domain" {
  name                = local.domain_zone_name
  resource_group_name = var.resource_group_name
  template_body       = file(local.arm_filename)
  lifecycle {
    ignore_changes = [parameters]
  }
  parameters = {
    "Name"          = local.domain_zone_name
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
  count      = try(var.settings.lock_zone, false) ? 1 : 0
  name       = "${local.domain_zone_name}-lock-zone"
  scope      = azurerm_dns_zone.domain_zone.id
  lock_level = "CanNotDelete"
  notes      = "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
}

resource "azurerm_management_lock" "lock_domain" {
  count      = try(var.settings.lock_domain, false) ? 1 : 0
  name       = "${local.domain_zone_name}-lock-domain"
  scope      = azurerm_template_deployment.domain.outputs.resourceID
  lock_level = "CanNotDelete"
  notes      = "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
}

resource "azurerm_dns_cname_record" "cname_records" {
  for_each = try(var.settings.records.cname_records, {})

  name                = each.value.name
  zone_name           = azurerm_dns_zone.domain_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.records
}