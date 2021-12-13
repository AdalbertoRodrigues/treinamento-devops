provider "aws" {
  region = "sa-east-1"
}

module "criar_instancia_da_erika" {
  source = "git@github.com:AdalbertoRodrigues/modulo_devops_terraform.git"
  nome = "ec2-adalberto-tf-module-01"
  tipo = "t2.micro"
}