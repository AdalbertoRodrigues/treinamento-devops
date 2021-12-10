resource "aws_vpc" "my_vpc" {
  cidr_block = "172.10.0.0/24"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-adalberto-tf"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.10.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sn-adalberto-tf"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "internet-gateway-adalberto-tf"
  }
}

resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
      {
        carrier_gateway_id         = ""
        cidr_block                 = "0.0.0.0/0"
        destination_prefix_list_id = ""
        egress_only_gateway_id     = ""
        gateway_id                 = aws_internet_gateway.gw.id
        instance_id                = ""
        ipv6_cidr_block            = ""
        local_gateway_id           = ""
        nat_gateway_id             = ""
        network_interface_id       = ""
        transit_gateway_id         = ""
        vpc_endpoint_id            = ""
        vpc_peering_connection_id  = ""
      }
  ]

  tags = {
    Name = "rt-adalberto-terraform"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.rt_terraform.id
}