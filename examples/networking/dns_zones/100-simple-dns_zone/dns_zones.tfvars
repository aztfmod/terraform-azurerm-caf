dns_zones = {
  dns_zone1 = {
    name               = "" // Set as empty for CI. this will creation a random_domain_name.com
    resource_group_key = "dns_re1"

    # You can create dns records using the following nested structure
    records = {
      a = {
        www1 = {
          name = "www1"
          resource_id = {
            public_ip_address = {
              key = "example_pip1_re1"
            }
          }
        }
      }
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
    }   //records
  }     //dns_zone1

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
      }   //cname

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
      }   //a

      srv = {
        dc1 = {
          name = "dc1"
          records = {
            target1 = {
              priority = 1
              weight   = 5
              port     = 8080
              target   = "target1.contoso.com"
            }
          }
        }
      } //srv
    }   //records
  }     //dns_zone2
}