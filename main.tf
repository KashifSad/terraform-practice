resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  

  tags = {
    Name = "vpc-aws-console"
  }
}




resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
   

  tags = {
    Name = "subnet-aws-console"
  }
}





resource "aws_security_group" "my_sg" {
  
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.my_vpc.id


  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    
  }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    
  }


  tags = {
    Name = "sg-aws-console"
  }
}





resource "aws_network_interface" "my_nic" {
  subnet_id       = aws_subnet.my_subnet.id
  private_ips    = ["10.0.1it.50"]
  
  
  tags = {
    Name = "nic-aws-console"
    }
}





resource "aws_instance" "my_instance" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.my_nic.id
    device_index         = 0
  }

  tags = {
    Name = "ec2-aws-console"
    }

}