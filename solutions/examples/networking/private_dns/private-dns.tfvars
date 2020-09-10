# rover -lz /tf/caf/examples/ -var-file /tf/caf/examples/networking/private_dns/private-dns.tfvars -a apply

resource_groups = {
  private_dns_region1 = {
    name   = "private-dns-rg"
    region = "region1"
  }
}

private_dns = {
  dns1 = {
    name               = "test-dns.mysite.com"
    resource_group_key = "private_dns_region1"

    records = {
      a_records = {
        testa1 = {
          name    = "*"
          ttl     = 3600
          records = ["1.1.1.1", "2.2.2.2"]
        }
        testa2 = {
          name    = "@"
          ttl     = 3600
          records = ["1.1.1.1", "2.2.2.2"]
        }
      }

      txt_records = {
        testtxt1 = {
          name = "testtxt1"
          ttl  = 3600
          records = {
            r1 = {
              value = "testing txt 1"
            }
            r2 = {
              value = "testing txt 2"
            }
          }
        }
      }
    }
  }
}