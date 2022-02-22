# This configuration demonstrates multiple implementations
# 1- OS Windows and Linux
# 2- instantiate container based on for_each, count or both
#

container_groups = {
  helloworld = {
    name                = "helloworld"
    region              = "region1"
    resource_group_key  = "rg1"
    ip_address_type     = "Private"
    os_type             = "Linux"
    restart_policy      = "Never" // Possible values are 'Always'(default) 'Never' 'OnFailure'
    network_profile_key = "np1"

    containers = {
      helloworld = {
        name   = "helloworld"
        image  = "mcr.microsoft.com/azuredocs/aci-helloworld"
        cpu    = "0.5"
        memory = "1.5"

        ports = {
          80 = {
            port     = 80
            protocol = "TCP"
          }
        }

        # for demo purposes
        environment_variables = {
          URL = "https://www.microsoft.com"
        }
      }

    } //containers

    tags = {
      environment = "testing"
    }

  } //helloworld

}
