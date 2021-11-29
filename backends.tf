terraform {
  backend "remote" {
    organization = "ozy-terraform"

    workspaces {
      name = "dev"
    }
  }
}