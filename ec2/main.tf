resource "aws_instance" "my_instance" {

  count = length(var.ec2_names)
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = var.ec2_names[count.index]
  }
}