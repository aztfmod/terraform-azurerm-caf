application_security_groups = {
  bastion = {
    name = "bastionappsecgw1"
    resource_group_key = "vm_region1"
        
  }

  app_server = {
    name = "appserverappsecgw1"
    resource_group_key = "vm_region1"
    
  }
}

