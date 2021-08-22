private_dns_vnet_link = {
  vnet_pvtdns_link1 = {        
    vnet_key = "vnet_key1"
    private_dns_zones = {            
      dns_zone1 = {
        name     = "vnet-pvtdns_link1"
        key = "dnszone_southeastasia"
        lz_key = "provide the landing zone key of private dns zone"
      }
      # dns_zone2 = {
      #   name     = "pvtdnstest-vnet1-link2"
      #   key = "dnszone_eastasia"
      
      # }
    }
  }  
  # vnet_pvtdns_link2 = {        
  #   vnet_key = "vnet_dev_test2"
  #   private_dns_zones = {
  #     dns_zone1 = {
  #       name     = "pvtdnstest-vnet2-link1"
  #       key = "aks_southeastasia"
  #     }
  #   }
  # }
}