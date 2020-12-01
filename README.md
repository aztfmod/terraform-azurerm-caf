[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-landingzone-modules&repo=aztfmod/terraform-azurerm-caf)

# Cloud Adoption Framework for Azure - Terraform module

Microsoft [Cloud Adoption Framework for Azure](https://aka.ms/caf) provides you with guidance and best practices to adopt Azure.

This module is used by the CAF landing zones to provision resources in an Azure subscription.

## Getting started

This module can be used to create resources on its own, or can be called from a CAF landing zone.

It can be invoked from the [Terraform registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/)

```terraform
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>0.4"
  # insert the 7 required variables here
}
```

## Prerequisites

- Setup your **environment** using the following guide [Getting Started](https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md) or you can alternatively use [Visual Studio Code Online]((https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf&repo=aztfmod/terraform-azurerm-caf)
) or GitHub Codespaces.
- Access to an **Azure subscription** where you have **Owner** role.


## Deploying examples

You can deploy examples either directly from this module or via the Cloud Adoption Framework's rover, to get starter, please refer to the [examples readme](./examples)

We categorize the various examples in this repo as follow:

| level | scenario                                                                                                                               | requirements                                       |
|-------|----------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| 100   | Start with this one! basic functionalities and features, no RBAC or security hardening - for demo and simple POC                       | working on any subscription with Owner permissions |
| 200   | intermediate functionalities includes diagnostics features and Azure Active Directory groups                                           | may need custom AAD permissions                    |
| 300   | advanced functionalities, includes RBAC features, virtual network and private link scenario and reduced portal view for hardened items | need custom AAD permissions                        |
| 400   | advanced functionalities, includes RBAC features and security hardening                                                                | need custom AAD permissions                        |


## Community

Feel free to open an issue for feature or bug, or to submit a PR.

In case you have any question, you can reach out to tf-landingzones at microsoft dot com.

You can also reach us on [Gitter](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

## Code of conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
