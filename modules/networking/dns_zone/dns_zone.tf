resource "azurerm_dns_zone" "domain_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_template_deployment" "domain" {
  name                = var.name
  resource_group_name = var.resource_group_name
  template_body       = file(local.arm_filename)
  lifecycle {
    ignore_changes = [parameters]
  }
  parameters = {
    "Name"          = var.name
    "key1"          = lookup(var.contract, "agreement_key1", "DNRA"),
    "key2"          = lookup(var.contract, "agreement_key2", "DNRA"),
    "AgreedBy"      = lookup(var.contract, "agree_by", "100.5.150.200:52212"), #Change to DevOps Agent IP
    "AgreedAt"      = timestamp(),
    "Address1"      = lookup(var.contract, "address1", ""),
    "Address2"      = lookup(var.contract, "address2", ""),
    "City"          = lookup(var.contract, "city", ""),
    "Country"       = lookup(var.contract, "country", ""),
    "PostalCode"    = lookup(var.contract, "postal_code", ""),
    "State"         = lookup(var.contract, "state", ""),
    "Email"         = lookup(var.contract, "email", ""),
    "Fax"           = lookup(var.contract, "fax", ""),
    "JobTitle"      = lookup(var.contract, "job_title", ""),
    "NameFirst"     = lookup(var.contract, "name_first", ""),
    "NameLast"      = lookup(var.contract, "name_last", ""),
    "NameMiddle"    = lookup(var.contract, "name_middle", ""),
    "Organization"  = lookup(var.contract, "organization", ""),
    "Phone"         = lookup(var.contract, "phone", ""),
    "autoRenew"     = lookup(var.contract, "auto_renew", false),
    "targetDnsType" = lookup(var.contract, "target_dnstype", "AzureDns"),
    "dnsZoneId"     = azurerm_dns_zone.domain_zone.id
  }

  deployment_mode = "Incremental"
  depends_on      = [azurerm_dns_zone.domain_zone]
}

resource "azurerm_management_lock" "lock_zone" {
  count      = var.lock_zone ? 1 : 0
  name       = "${var.name}-lock-zone"
  scope      = azurerm_dns_zone.domain_zone.id
  lock_level = "CanNotDelete"
  notes      = "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
}

resource "azurerm_management_lock" "lock_domain" {
  count      = var.lock_domain ? 1 : 0
  name       = "${var.name}-lock-domain"
  scope      = azurerm_template_deployment.domain.outputs.resourceID
  lock_level = "CanNotDelete"
  notes      = "Deleting a domain will make it unavailable to purchase for 60 days. Please remove the lock before deleting this domain."
}


