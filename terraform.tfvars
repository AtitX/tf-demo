# environment        = "staging"
# key_name           = "staging-key"
# region             = "ap-southeast-1"
# availability_zone  = "ap-southeast-1a"

# # vpc
# vpc_cidr            = "10.60.0.0/16"
# public_subnet_cidr  = "10.60.1.0/24"
# private_subnet_cidr = "10.60.2.0/24"

# # web
# web_instance_count  = 1

# # TW HQ Access
# tw_cidr_blocks = "61.91.34.58/32"

# # vps_mattermost
# vps_mattermost_instance_count  = 1

# # vps_taskworld
# vps_taskworld_instance_count  = 1
region = "ap-southeast-1"
instance_type = "t2.micro"
# key_pair_name = "sa-east-1-dedi-k3s"
name = "brazil"
# private_subnet_ids = ["subnet-06548f558415372f4","subnet-0c47cf28de8f6a039","subnet-0ff3bffb0e9aa2fcb"]
public_subnet_ids = ["subnet-0d8bc1a848f51048e"]
security_group_id = "sg-00b0fa912b0a17544"



volume_type = "gp2"
root_volume_size = "100"
ebs_volume_size = "500"
# iam_role = "k3s-dedi-servers-role"
instances_number = "1"
# environment = "sa-east-1"
# ami = "ami-09887484cc0721114"
domain = "dosthailand.com"
