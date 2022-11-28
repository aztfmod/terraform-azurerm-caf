
# If you need to reference an existing DNS Zone, the following structure must be used
dns_zone_records = {
  record1 = {
    dns_zone = {
      # name     = "name of an existing dns_zone"
      # resource_group_name = "set the name when the id is provided"
      key = "dns_zone1"
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
        example_alias = {
          name = "example-alias"
          ttl  = 1
          resource_id = {
            public_ip_address = {
              key = "example_pip1_re1"
            }
          }
        }
      } //a
    }   //records
  }     //record1

  #
  # Example to reference an existing dns_zone in the target subscription
  #
  # record2 = {
  #   dns_zone = {
  #     name                = "sfjcnwejcwejvwe.com"
  #     resource_group_name = "example-resources"
  #   }

  #   records = {

  #     cname = {
  #       www_fr = {
  #         name   = "www-fr"
  #         record = "www.bing.fr"
  #       }
  #     } //cname

  #     a = {
  #       dns = {
  #         name = "dns"
  #         records = [
  #           "10.10.1.1", "172.10.2.2"
  #         ]
  #       }
  #     } //a
  #   }   //record2
  # }
}