terraform {
  backend "remote" {
    organization = "aztfmod"

    workspaces {
      name = "example_standalone_private-dns_100-private-dns-vnet-links"
    }
  }
}
