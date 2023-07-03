# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob

resource "azurerm_storage_blob" "blob" {

  name                   = var.settings.name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = try(var.settings.type, "Block")
  size                   = try(var.settings.size, null)
  access_tier            = try(var.settings.access_tier, "Hot")
  content_type           = try(var.settings.content_type, null)
  content_md5            = try(var.settings.content_md5, null)
  source                 = local.source
  source_content         = local.source_content
  source_uri             = try(var.settings.source_uri, null)
  parallelism            = try(var.settings.parallelism, 8)
  metadata               = try(var.settings.metadata, null)

  lifecycle {
    replace_triggered_by = [
      random_id.md5
    ]
  }
}

resource "random_id" "md5" {
  keepers = {
    md5 = local.md5_content
  }
  byte_length = 8
}

locals {
  md5_content = local.source != null ? filebase64sha512(local.source) : sha512(local.source_content)

  source = can(var.settings.source) || can(fileexists(format("%s/%s", var.var_folder_path, var.settings.source))) ? try(
    format("%s/%s", var.var_folder_path, var.settings.source),
    var.settings.source
  ) : null

  source_content = can(var.settings.source_content) || can(fileexists(format("%s/%s", var.var_folder_path, var.settings.source_content))) ? try(
    file(format("%s/%s", var.var_folder_path, var.settings.source_content)),
    var.settings.source_content
  ) : null
}