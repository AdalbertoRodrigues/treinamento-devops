data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "type" {
  type = string 
  default = "t2.micro"
}

variable "subnet" {
  type = string 
  description = "Qual a subnet?"

  default = "subnet-026188ad722fd00ef"
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web2" {
  subnet_id = var.subnet
  ami = data.aws_ami.ubuntu.id
  instance_type = var.type
  key_name = "dev-turma3-adalberto" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-0bd9323977bbcdd77"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-adalberto-tf-01"
  }
}

output "ssh" {
  value = "${aws_instance.web2.private_ip}"
}