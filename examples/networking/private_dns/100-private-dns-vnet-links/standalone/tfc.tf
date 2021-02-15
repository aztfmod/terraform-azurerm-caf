terraform {
  backend "remote" {
    organization = "aztfmod"

    workspaces {
      name = "laurent"
    }
  }
}