variable "sg_id" {
    description = "SG ID for load balancer"
    type = string

}

variable "private_subnet_id" {
    description = "Private Subnet ID for load balancer"
    type = string

}

variable "vpc_id" {
    description = " VPC ID for load balancer"
    type = string

}

variable "my_instance" {
    description = " instances id for target group attachment"
    type = list(string)


}