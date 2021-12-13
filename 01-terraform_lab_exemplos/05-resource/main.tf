# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_instance" "web" {
#   ami           = "ami-09e67e426f25ce0d7"
#   instance_type = "t2.micro"
#   subnet_id              = "subnet-eddcdzz4"
#   # availability_zones = ["us-east-1"] # configurando zona para criar maquinas
#   tags = {
#     Name = "Minha Maquina Simples EC2"
#   }
#   volume_id = aws_ebs_volume.itau_volume_encrypted.id
# }


# resource "aws_ebs_volume" "itau_volume_encrypted" {
#   size      = 8
#   encrypted = true
#   tags      = {
#     Name = "Volume itaú"
#   }
# }



##### Caso Itaú #####
# aws configure # maquina pessoal
# nas do itaú colocar as variáveis de ambiente no bashrc
# https://docs.aws.amazon.com/sdkref/latest/guide/environment-variables.html
# configurar via environment variable
# export AWS_ACCESS_KEY_ID=""
# export AWS_SECRET_ACCESS_KEY=""
# export AWS_DEFAULT_REGION=""

# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_instance" "web" {
#   ami = "ami-09e67e426f25ce0d7"
#   instance_type = "t3.micro"
#   subnet_id = "subnet-05880ea9006199004"
  
#   tags = {
#     Name = "MinhaPrimeiraMaquina-Carol  "
#   }
# }

# resource "aws_ebs_volume" "itau_volume_encrypted" {
#   size      = 8
#   encrypted = true
#   availability_zone = "us-east-1a"
#   tags      = {
#     Name = "Volume itaú"
#   }
# }

# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.itau_volume_encrypted.id
#   instance_id = aws_instance.web.id
# }

# Gamaacademythree-sbx - # passago a chave pelo pessoal de segurança itaú
# export AWS_ACCESS_KEY_ID="3232323232"
# export AWS_SECRET_ACCESS_KEY="34433444sssdd3+ssa/dd434343"

# //////

# variable "name" {
#   type: string 
# }


variable "type" {
  type = string 
  description = "Qual o tipo?"

  default = "t2.micro"

  # validation {
  #   condition     = substr(var.type, 0, 1) == "t" && substr(var.type, 2, 1) == "."
  #   error_message = "Tipo digitado incorretamente."
  # }
}

variable "subnet" {
  type = string 
  description = "Qual a subnet?"

  default = "subnet-026188ad722fd00ef"

  # validation {
  #   condition     = length(var.subnet == 24 )
  #   error_message = "Subnet fora do padrão!"
  # }
}

variable "quantidade" {
  type = number

  description = "Qual a quantidade?"

  # validation = {
  #   condition = var.quantidade <= 5 && var.quantidade > 0
  #   error_message = "Insira um valor maior que 0 e menor que 5!"
  # }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web2" {
  count = var.quantidade
  subnet_id = var.subnet
  ami = "ami-0d022c6b66ef85884"
  instance_type = var.type
  key_name = "dev-turma3-adalberto" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-0bd9323977bbcdd77"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-adalberto-tf-0${count.index}"
  }
}

output "ssh" {
  value       = [
    for key, value in range(var.quantidade):
      "${aws_instance.web2[key].private_ip}"
  ]
}



resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0YWlWsWlk2jbIB+5MDl3WFAubSVO836bH5Btz8aL4CHPMwC9I73yLsr8mPFLhKwJr0gYWLZEQ9BBC7p2/YzJqnDeR+azdRB8HE71Q+vPTL3645CaUvVkIy7b5R7dgFlVrFY+nsoGffnkOkeYHclWFXTU14YJVlM2ZLc2K9okKBwRqeocjg0V7pCyH9oxlxlkl07G/4scjrt7loVlcdP4cvsPuVriE/KZfOjVh5p4hUlbnZgKTao2SNLra6jt7dVcXYKwWRgxBNVkpRpe31S/FyYNBagHQLiqResjJ9C1cPj6WHMVPJm7WhJUQpeqYrkuQutZ5QdKczk5gepa589XWga401knwa6YH+viBStike//GsEbcGzKqwf7/oe+cMsfuxKJD+P6RxXEYGcXrgaZSViH9C01w/siairW4N5sGcLdaaK31JRqTRUyU7GqxW8iEU4ixhbVEej0O4WkqChhTy9+mue5i5IWm8urOOy6NKTePa9Xwu3nc/AVWGnqKugc= ubuntu@dev-adalberto"
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABUAHUAHuaHaUhAUhAUAiqHA541BsJFngWPqlx27QdAZEWdMLvJv5Wguvatb6LIDo1V3rJ4mUtRRs0o2q3LwYiA5CIkiHFXyNVhXTF1WNAbRossUMsu/BzmgEKyIPPgPHeM0PyRi6FuW1TTZYdnO/GCzJ0UMvZFKnr2g6rELWgdc9Clxz8peNJ+iPJx/sJb+DxTuHDJc1U9eOYS7vlwzsHHApD9O+DbWnpwRpSEuX3vjm5pEEAPqrcBD3HK8kH2qMVRZNxg/fSzSrzjCwFV3ShNbKSTD6HYBV2xCY18mRFjyW94BPSBDGel7/kqTmXY4jtbAoyycWRZJFYhCdzNfItT69nHmsT3i09e0J9jNI6CaameQg/cwIOt8fl+lxUIAufHqFDJPGMJcNFoVR7t7yWPXN3qev2OlGnQONDVlNOmIJDrO+r2QeoVcKaxKye7G3HD3u4HuqGYfL9MtCo6pOZ8IZsCCj2KpS4KQCc="
}


# /////

# aws_instance.web.public_id
