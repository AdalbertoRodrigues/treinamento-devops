terraform {
  backend "remote" {
    organization = "ALPHA_GAMA"

    workspaces {
      name = "modulo_tf"
    }
  }
}