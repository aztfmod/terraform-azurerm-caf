global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  dns_re1 = {
    name   = "sales-rg1"
    region = "region1"
  }
}

dns_zones = {
  dns_zone1 = {
    name               = "" // Set as empty for CI. this will creation a random_domain_name.com
    resource_group_key = "dns_re1"

    # You can create dns records using the following nested structure
    records = {
      cname = {
        www_com = {
          name   = "www"
          record = "www.bing.com"
        }
        ftp_co_uk = {
          name   = "ftp"
          record = "www.bing.co.uk"
          tags = {
            project = "prod_crm"
          }
        }
      } //cname
    } //records
  } //dns_zone1
  
  dns_zone2 = {
    name               = "" // Set as empty for CI. this will creation a random_domain_name.com
    resource_group_key = "dns_re1"

    records = {
      cname = {
        www_co_uk = {
          name   = "www"
          record = "www.bing.co.uk"
        }
        www1 = {
          name = "www1"
          # You can also reference an alias resord set
          resource_id = {
            # to an existing zone recordset
            dns_zone_record = {
              key = "www_co_uk"
            }
          }
        } //www1
      } //cname

      caa = {
        test = {
          name = "test"
          ttl  = 60
          tags = {
            project = "prod_crm"
          }
          records = {
            1 = {
              flags = 0
              tag   = "issue"
              value = "example.com"
            }
            2 = {
              flags = 0
              tag   = "issue"
              value = "example.net"
            }
            3 = {
              flags = 1
              tag   = "iodef"
              value = "mailto:terraform@nonexisting.tld"
            }
          }
        }
      } //caa

      

      a = {
        dns = {
          name = "dns"
          records = [
            "10.10.1.1", "172.10.2.2"
          ]
        } //dns
        
        dns1 = {
          name = "dns1"
          # You can also reference an alias resord set
          resource_id = {
            # to an existing zone recordset
            dns_zone_record = {
              key = "dns"
            }
          }
        } //www1
      } //a
    } //records
  } //dns_zone2
}

# If you need to reference an existing DNS Zone, the following structure must be used
dns_zone_records = {
  record1 = {
    dns_zone = {
      # name     = "name of an existing dns_zone" 
      # resource_group_name = "set the name when the id is provided"
      key    = "dns_zone1" 
      # lz_key = "name of the remote landingzone"
    } //dns_zone

    records = {
      
      cname = {
        www_fr = {
          name   = "www-fr"
          record = "www.bing.fr"
        }
      } //cname

      a = {
        dns = {
          name = "dns"
          records = [
            "10.10.1.1", "172.10.2.2"
          ]
        }
      } //a
    } //records
  } //record1

  #
  # Example to reference an existing dns_zone in the target subscription
  #
  record2 = {
    dns_zone = {
      name                = "sfjcnwejcwejvwe.com"
      resource_group_name = "example-resources"
    }

    records = {
      
      cname = {
        www_fr = {
          name   = "www-fr"
          record = "www.bing.fr"
        }
      } //cname

      a = {
        dns = {
          name = "dns"
          records = [
            "10.10.1.1", "172.10.2.2"
          ]
        }
      } //a
    } //record2
  }
}