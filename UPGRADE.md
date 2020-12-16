Updgrade notes

When ugrading to a newer version of the CAF module, some configuration structures must be updated before applying the modifications.

# 4.21.0

## Virtual machines

Example of the updated sturcture
/examples/compute/virtual_machine/211-vm-bastion-winrm-agents/virtual_machines.tfvars

Replace 
```hcl
admin_user_key = "vm-win-admin-username"
```

by
```hcl
admin_username_key = "vm-win-admin-username"
```