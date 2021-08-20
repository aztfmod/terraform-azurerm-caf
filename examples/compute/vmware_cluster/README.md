# Azure Compute Resources

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```


## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

```hcl
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

resource_groups = {
  rgvwc = {
    name   = "vmwarecluster-test"
    region = "region1"
  }
}

keyvaults = {
  kv_rg1 = {
    name               = "kv1"
    resource_group_key = "rgvwc"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

dynamic_keyvault_secrets = {
  kv_rg1 = { # Key of the keyvault
    secret_key1 = {
      secret_name = "nsxt-password"
      value       = "123#sadd$saASD"
    }
    secret_key2 = {
      secret_name = "vcenter-password"
      value       = "123#sadd$saASD"
    }
  }
}

vmware_private_clouds = {
  vwpc1= {
    name                = "example-vmware-private-cloud"
    resource_group_key = "rgvwc"
    region                  = "region1"
    sku_name            = "av36"
    management_cluster = {
      size = 3
    }
    network_subnet_cidr         = "192.168.48.0/22"
    internet_connection_enabled = false

    nsxt_password = {
      #password = "123#sadd$saASD"
      keyvault_key = "kv_rg1"
      #lzKey= "ejkle" (optional)
      secret_key = "secret_key1"      
    }
    vcenter_password = {
      keyvault_key = "kv_rg1"
      #lzKey= "ejkle" (optional)
      secret_name = "vcenter-password"
    }
  }
}

vmware_clusters = {
  vwc1 = {
    name               = "example-Cluster"
    vmware_private_cloud_key   = "vwpc1"
    cluster_node_count = 3
    sku_name           = "av36"
  }
}

vmware_express_route_authorizations = {
  vwera1={
    name             = "example-authorization"
    vmware_private_cloud_key = "vwpc1"
  }
}
```
#vmware_clusters

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|name | Resource name | `string` |  | true |
|vmware_private_cloud_key | Key of the related vmware_private_cloud | `string` |  | true |
|cluster_node_count | Number of nodes | `number` |  | true |
|sku_name | Number of nodes (av20,av36,av36t) | `string` |  | true |


## Outputs
| Name | Description |
|------|-------------|
| id | The ID of the created vmware_cluster |
|cluster_number | A number that identifies this Vmware Cluster in its Vmware Private Cloud. |
|hosts | A list of host of the Vmware Cluster.

#vmware_private_clouds

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|name | Resource name | `string` |  | true |
|resource_group_key | Key of the resource group | `string` |  | true |
|region | Key of the region to be deployed | `string` |  | true |
|sku_name | Number of nodes (av20,av36,av36t) | `string` |  | true |
|management_cluster | Object containing (size `number`) representing the size of the management cluster. | `object` |  | true |
|network_subnet_cidr | Subnet with mask. | `string` |  | true |
|internet_connection_enabled | Is the Private Cluster connected to the internet? | `bool` |  | false |
|nsxt_password |The password of the NSX-T Manager. Changing this forces a new Vmware Private Cloud to be created. | `string` |  | false |
|vcenter_password |The password of the vCenter admin. Changing this forces a new Vmware Private Cloud to be created. | `string` |  | false |
|tags |A mapping of tags which should be assigned to the Vmware Private Cloud. | `object` |  | false |

###management_cluster

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|size |The size of the management cluster. This field can not updated with `internet_connection_enabled` together. | `number` |  | false |

## Outputs
| Name | Description |
|------|-------------|
|id | The ID of the Vmware Private Cloud. |
|circuit | A circuit block as defined below. |
|management_cluster | A management_cluster block as defined below. |
|hcx_cloud_manager_endpoint | The endpoint for the HCX Cloud Manager. |
|nsxt_manager_endpoint | The endpoint for the NSX-T Data Center manager. |
|vcsa_endpoint | The endpoint for Virtual Center Server Appliance. |
|nsxt_certificate_thumbprint | The thumbprint of the NSX-T Manager SSL certificate. |
|vcenter_certificate_thumbprint | The thumbprint of the vCenter Server SSL certificate. |
|management_subnet_cidr | The network used to access vCenter Server and NSX-T Manager. |
|provisioning_subnet_cidr | The network which is used for virtual machine cold migration, cloning, and snapshot migration. |
|vmotion_subnet_cidr | The network which is used for live migration of virtual machines. |

###circuit
| Name | Description |
|------|-------------|
|express_route_id | The ID of the ExpressRoute Circuit.|
|express_route_private_peering_id | The ID of the ExpressRoute ||Circuit private peering.|
|primary_subnet_cidr | The CIDR of the primary subnet.|
|secondary_subnet_cidr | The CIDR of the secondary subnet.|


###management_cluster
| Name | Description |
|------|-------------|
|id | The ID of the management cluster.|
|hosts | A list of hosts in the management cluster.|

#vmware_express_route_authorizations
## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|name | he name which should be used for this Express Route Vmware Authorization. Changing this forces a new Vmware Authorization to be created. | `string` |  | true |
|private_cloud_id  | The ID of the Vmware Private Cloud in which to create this Express Route Vmware Authorization. Changing this forces a new Vmware Authorization to be created. | `string` |  | true |
## Outputs
| Name | Description |
|------|-------------|
|id | The ID of the Vmware Authorization.|
| express_route_authorization_id | The ID of the Express Route Circuit Authorization.|
| express_route_authorization_key | The key of the Express Route Circuit Authorization.|