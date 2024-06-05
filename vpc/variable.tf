variable "public_subnet_cidrs" {
 type        = string
 description = "Public Subnet CIDR values"
 default     = "10.0.1.0/24"
}
 
variable "private_subnet_cidrs" {
 type        = string
 description = "Private Subnet CIDR values"
 default     = "10.0.4.0/24"
}

variable "azs1" {
    type = string
    description = "Availability Zones"
    default = "us-east-1a"
}

variable "azs2" {
    type = string
    description = "Availability Zones"
    default = "us-east-1b"
}
