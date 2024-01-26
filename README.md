# Cloud Adoption Framework for Azure - Terraform module

> :warning: This solution, offered by the Open-Source community, will no longer receive contributions from Microsoft. Customers are encouraged to transition to [Microsoft Azure Verified Modules](https://aka.ms/avm) for Microsoft support and updates.

This module allows you to create resources on Microsoft Azure, is used by the Azure Terraform SRE to provision resources in an Azure subscription and can deploy resources being directly invoked from the Terraform registry.

## Prerequisites

- Setup your **environment** using the following guide [Getting Started](https://github.com/aztfmod/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md) or you use it online with [GitHub Codespaces](https://github.com/features/codespaces).
- Access to an **Azure subscription**.

## Getting started

This module can be used inside [:books: Azure Terraform Landing zones](https://aztfmod.github.io/documentation/), or can be used as standalone, directly from the [Terraform registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/)

```terraform
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"
  # insert the 7 required variables here
}
```

Fill the variables as needed and documented, there is a [quick example here](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples/standalone.md).

For a complete set of examples you can review the [full library here](https://github.com/aztfmod/terraform-azurerm-caf/tree/master/examples).

<img src="https://aztfmod.azureedge.net/media/standalone.gif" width="720"/> <br/> <br/>

## Community

Feel free to open an issue for feature or bug, or to submit a PR, [Please check out the WIKI for coding standards, common patterns and PR checklist.](https://github.com/aztfmod/terraform-azurerm-caf/wiki)

You can also reach us on [Gitter](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit <https://cla.opensource.microsoft.com>.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.
