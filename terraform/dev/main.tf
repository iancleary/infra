terraform {
  cloud {
    organization = "iancleary"

    workspaces {
      name = "infra-dev"
    }
  }
}
