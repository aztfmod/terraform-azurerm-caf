resource "azurecaf_name" "vwc" {
  name          = var.settings.name
  resource_type = "azurerm_vmware_cluster"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vmware_cluster

resource "azurerm_vmware_cluster" "vwc" {
  name               = azurecaf_name.vwc.result
  vmware_cloud_id    = var.vmware_cloud_id
  cluster_node_count = var.settings.cluster_node_count
  sku_name           = var.settings.sku_name
}