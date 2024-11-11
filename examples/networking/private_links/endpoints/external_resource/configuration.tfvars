private_endpoints = {
  ingress_test = {  
    #lz_key     = ""
    vnet_key   = "vnet"
    subnet_keys = ["private_endpoints"]
    external_resources = {
      ingress_link = {
        name       = "aks-ingress"
        resource_group_key = "rg"
        private_service_connection = {
          name                 = "aks-ingress-psc"
          is_manual_connection = false
          resource_alias = "somerandomlink.westeurope.azure.privatelinkservice"
        }
      }
    }
  }
}