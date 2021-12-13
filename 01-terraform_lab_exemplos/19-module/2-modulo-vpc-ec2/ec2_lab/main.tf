provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami                     = data.aws_ami.ubuntu.id
  count                   = length(var.config)
  instance_type           = var.config[count.index].Tipo
  key_name                = "dev-turma3-adalberto" # key chave publica cadastrada na AWS 
  subnet_id               = var.config[count.index].SubnetId # vincula a subnet direto e gera o IP automático
  vpc_security_group_ids  = [
    aws_security_group.allow_ssh_terraform.id,
  ]
  
  root_block_device {
    encrypted = true
    volume_size = 8
  }

  tags = {
    Name = "Maquina para testar VPC do terraform - ${var.config[count.index].Nome}"
  }
}
