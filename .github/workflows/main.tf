

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "instance_sg_"

  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_instance" "ec2_instance_1" {
  ami           = "ami-12345678"  # machine number. 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "EC2_Instance_1"
  }

  security_groups = [aws_security_group.instance_sg.id]
}

resource "aws_instance" "ec2_instance_2" {
  ami           = "ami-12345678"  # machine number
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "EC2_Instance_2"
  }

  security_groups = [aws_security_group.instance_sg.id]
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"  # has to be unique. 
  acl    = "private"

  tags = {
    Name = "MyS3Bucket"
  }
}
