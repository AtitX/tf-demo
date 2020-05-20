# variable "environment" {
#   default = "staging"
# }
# variable "key_name" {
#   description = "The aws keypair to use"
# # }
variable "region" {
  description = "Region that the instances will be created"
}
# variable "availability_zone" {
#   description = "The AZ that the resources will be launched"
# }
# # Networking
# variable "vpc_cidr" {
#   description = "The CIDR block of the VPC"
# }
# variable "tw_cidr_blocks" {
#   description = "The CIDR block of TW"
# }
# variable "public_subnet_cidr" {
#   description = "The CIDR block of the public subnet"
# }
# variable "private_subnet_cidr" {
#   description = "The CIDR block of the private subnet"
# }
# # Web
# variable "web_instance_count" {
#   description = "The total of web instances to run"
# }
# # vps_mattermost
# variable "vps_mattermost_instance_count" {
#   description = "The total of vps instances to run"
# }
# # vps_taskworld
# variable "vps_taskworld_instance_count" {
#   description = "The total of vps instances to run"
# }



# variable "ami" {
  # default = "ami-09887484cc0721114"
# }

variable "name" {
  # default = "ami-09887484cc0721114"
}

variable "instance_type" {
  # default = "m5a.xlarge"
}

variable "security_group_id" {
  # default = "sg-0e7dbc956b9afcdb6"
}

variable "volume_type" {
  # default = "gp2"
}

variable "root_volume_size" {
  # default = "100"
}

variable "ebs_volume_size" {
  # default = "500"
}


# variable "key_pair_name" {
#   # default = "us-east-2-dedi-k3s"
# }

# variable "iam_role" {
#   # default = "k3s-dedi-servers-role"
# }
variable "instances_number" {
  default = "1"
}

# variable "private_subnet_ids" {
#   type    = list
#   # default = ["subnet-0688c50d98006e0a4"]
# }

variable "public_subnet_ids" {
  type    = list
  # default = ["subnet-094fe18d7cf9f0815"]
}

# variable "environment" {
#   # default = "us-east-2"
# }
variable "domain" {
  type = string
}
# variable "access_key" {}
# variable "secret_key" {}
