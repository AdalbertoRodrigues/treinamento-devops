terraform {
  required_version = ">= 0.12" # colocando compatibilidade do terraform para 0.12
}

resource "aws_instance" "web" {
  ami           = "ami-0d022c6b66ef85884"
  subnet_id = "subnet-026188ad722fd00ef"
  instance_type = var.tipo
  key_name = "dev-turma3-adalberto"
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-0bd9323977bbcdd77"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "${var.nome}",
    Itau = true
  }
}