# Azure Compute Resources

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```

Under the compute category you can create the following resources, with their examples:

| Technology                  | Examples Directory                                                                                                           |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------|
| Availability Sets           | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/availability_set/)         |
| Azure Container Instances   | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/container_groups)          |
| Azure Container Registry    | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/container_registry)        |
| Azure Dedicated Hosts       | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/dedicated_hosts)           |
| Azure Kubernetes Services   | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/kubernetes_services)       |
| Proximity Placement Groups  | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/computep/roximity_placement_group) |
| Virtual Machines            | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/virtual_machine)           |
| Virtual Machines Scale sets | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/virtual_machine_scale_set) |
| VMware Clusters             | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/vmware_cluster)            |
| Azure Virtual Desktop       | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/compute/azure_virtual_desktop)     |