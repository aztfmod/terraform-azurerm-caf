# Windows Virtual Desktop 

This sub module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this module inside your Terraform code either as a module or as a sub module directly from the [Terraform Registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/latest) using the following calls:

Complete module:
```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "4.21.2"
  # insert the 6 required variables here
}
```
## Pre-requisits using powershell

1) Create a WVD tenant using powershell
   a) Import following module using powershell.
        Import-Module -Name Microsoft.RDInfra.RDPowerShell
   b) Use the follwing command and authenticate using your credentials.
        Add-RdsAccount -DeploymentUrl https://rdbroker.wvd.microsoft.com
          Note: If windows virtual desktop is not activated for the account, do it from https://rdweb.wvd.microsoft.com/)
   c) Add the following environment values from your environment.
        $tenantName = "test-wvd"   #Name for WVD Tenant
        $TenantId = "00000000-0000-0000-0000-000000000000"  # Replace the value with your AD Tenant ID
        $subscriptionId= "00000000-0000-0000-0000-000000000000"  # Replace the value with your subscription ID
   d) Create the WVD tenant using the below command
        New-RdsTenant -Name $tenantName -AadTenantId $TenantId -AzureSubscriptionId $subscriptionId
          Note: Tenant creator role needs to be added for the user. From the azure portal
          Go to Enterprise applications > windows virtual desktop > add user > Add Tenant creator role for the user. 

2) Create RDS Role assignment using the below command
     New-RdsRoleAssignment -RoleDefinitionName "RDS Owner" -ApplicationId "00000000-0000-0000-0000-000000000000" -TenantName $tenantName
     # ApplicationId value should be replaced with the SP secret value of wvd-tenant-client-id which we have created using wvd_app_group_pre-requisit example.

3) Create RDS hostpool and tenant association
     New-RdsHostPool  -TenantName "$tenantName" -Name "firsthp"
     # Replace "firsthp" with the hostpool name which you want to create.

  


## Run this example with rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/compute/wvd_application_group \
  -level level1 \
  -tfstate wvd-post.tfstate \
  -a [plan | apply | destroy]
```

Note: If your ADDS is in another vnet as WVD VM vNet, you have to comment out virtual machine extensions first and then once the VM is created, do vNet peering manually before you uncomment and run the extentions in       .tfvars file.  

