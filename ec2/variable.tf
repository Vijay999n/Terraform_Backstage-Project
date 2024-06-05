variable "sg_id" {
    description = "SG ID for EC2 instance"
    type = string

}

variable "private_subnet_id" {
    description = "private Subnet ID for EC2 instance"
    type = string
    
}
variable "ec2_names" {
    description = "EC2 Names"
    type = list(string)
    default = ["Master_Node", "Worker_Node1", "Worker_Node2"]

}
variable "ec2_ami" {
 type = string
  description = "ami for ec2 instance"
  default = "ami-04b70fa74e45c3917"
}


variable "ec2_instance_type" {
 type = string
  description = "ec2 instance type"
  default = "t2.micro"
}