private_dns_vnet_links = {
  vnet_pvtdns_link1 = {        
    vnet_key = "vnet_key1"
    #lz_key = "remote landing zone key for vnet"
    private_dns_zones = {            
      dns_zone1 = {
        name     = "vnet1-link1"
        key = "dnszone1_key"
        lz_key = "provide the landing zone key of private dns zone"
      }
      # dns_zone2 = {
      #   name     = "vnet1-link2"
      #   key = "dnszone2_key"
      # }
    }
  }  
  # vnet_pvtdns_link2 = {        
  #   vnet_key = "vnet_key2"
  #   private_dns_zones = {
  #     dns_zone1 = {
  #       name     = "vnet2-link1"
  #       key = "dnszone1_key"
  #     }
  #   }
  # }
}