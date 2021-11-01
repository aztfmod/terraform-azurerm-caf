
#
# Definition of the networking security groups
#
network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {
    version            = 1
    resource_group_key = "rg1"
    name               = "empty_nsg"

    nsg = []
  }

}
