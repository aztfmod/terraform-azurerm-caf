# Azure Networking

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

Under the networking category you can create the following resources, with their examples:

| Technology                               | Examples Directory                                                                                                                        |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| Azure Bastion                            | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/bastion/)                            |
| Azure CDN                                | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/cdn)                                 |
| Azure DNS Zones                          | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/dns_zones)                           |
| Azure Domain Name Registration           | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/domain_name_registrations)           |
| ExpressRoute                             | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/express_routes)                      |
| Azure Firewall                           | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/firewall)                            |
| Azure FrontDoor                          | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/front_door)                          |
| Azure Load Balancers                     | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/lb)                                  |
| Azure NAT Gateways                       | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/nat_gateways)                        |
| Azure Private DNS                        | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/private_dns)                         |
| Azure Private DNS Link                   | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/private_dns_vnet_link)               |
| Azure Virtual Network                    | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/virtual_network)                     |
| Azure Virtual Subnet                     | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/virtual_subnets)                     |
| Azure Virtual Network Gateway            | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/virtual_network_gateway)             |
| Azure Virtual Network Gateway Connection | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/virtual_network_gateway_connections) |
| Azure Virtual Virtual WAN                | [GitHub repository](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/networking/virtual_wan)                         |
