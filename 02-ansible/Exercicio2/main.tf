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
  default = "t2.medium"
}

variable "subnet" {
  type = string 
  description = "Qual a subnet?"

  default = "subnet-026188ad722fd00ef"
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_adalberto_2"
  description = "Allow SSH inbound traffic"
  vpc_id = "vpc-0a194c591c05ac7a4"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups = null,
      self            = null
    },
    {
      description      = "HTTP livre"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups = null,
      self            = null
    },
    {
      description      = "porta java"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups = null,
      self            = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups  = null,
      self             = null,
      description      = "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_ssh_adalberto_2"
  }
}



resource "aws_instance" "web2" {
  subnet_id = var.subnet
  ami = data.aws_ami.ubuntu.id
  instance_type = var.type
  key_name = "dev-turma3-adalberto" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh.id] #["sg-0bd9323977bbcdd77"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-adalberto-ansible-exercicio-2"
  }
}

resource "local_file" "arquivo_hosts" {
  filename = "hosts"
  content = aws_instance.web2.private_ip
}

resource "local_file" "arquivo_acesso" {
  filename = "acesso.txt"
  content = aws_instance.web2.public_ip
}

output "public_ip" {
  value = "${aws_instance.web2.public_ip}"
  description = "ip publico"
}
