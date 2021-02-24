application_security_groups = {
  bastion = {
    name = "bastionappsecgw1"
    resource_group_key = "vm_region1"
    
  }

  workloads = {
    name = "workloadsappsecgw1"
    resource_group_key = "vm_region1"
  }
}


