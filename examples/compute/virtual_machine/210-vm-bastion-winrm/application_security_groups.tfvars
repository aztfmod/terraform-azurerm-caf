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

networking_interface_asg_associations = {
  nic0 = {
    name = "bastionasg"
    resource_group_key = "vm_region1"
    application_security_group_key = "bastion"
  }
}



