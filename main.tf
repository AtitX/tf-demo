provider "aws" {
  region = var.region
  # profile                 = "dos"
}

# resource "aws_key_pair" "key" {
#   key_name   = "${var.key_name}"
#   public_key = "${file("staging_key.pub")}"
# }

data "aws_ami" "latest-debian" {
  most_recent = true

  owners = ["379101102735"]
  # owner_id = "379101102735"

  filter {
    name = "name"

    values = [
      "debian-stretch-hvm-x86_64-gp2*",
    ]
  }

  # filter {
  #   name = "owner-alias"

  #   values = [
  #     "amazon",
  #   ]
  # }
}


module "ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "${var.name}"
  instance_count         = "${var.instances_number}"

  # ami                    = "${var.ami}"
  ami           = data.aws_ami.latest-debian.id
  instance_type          = "${var.instance_type}"
  # key_name               = "${var.key_pair_name}"
  # key_name               = "${var.region}-dedi-k3s"
  monitoring             = false

  vpc_security_group_ids = ["${var.security_group_id}"]
  subnet_ids             = "${var.public_subnet_ids}"
  root_block_device      = [
          {
            device_name = "xvda"
            volume_type = "${var.volume_type}"
            # volume_size = "30"
            volume_size = "${var.root_volume_size}"
            encrypted   = true
          },
  ]

  ebs_block_device      = [
          {
            device_name = "/dev/sdb"
            volume_type = "${var.volume_type}"
            volume_size = "${var.ebs_volume_size}"
            #volume_size = "20"
            encrypted   = true
          },
  ]

  # iam_instance_profile = "${var.iam_role}"

  associate_public_ip_address = "true"
  # user_data             = "${file("setup.sh")}"

  tags = {
    Terraform   = "true"
    Environment = "${var.region}"
  }
}


resource "aws_route53_record" "www" {
#   zone_id = "aws_route53_zone.main.zone_id"
  # zone_id = "ZREXIKAS7RS2W"
  zone_id = "Z1BRSAQJRYTCY8"
  name    = "${var.name}.dosthailand.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.this.public_ip}"]
}

# resource "aws_route53_record" "inbound" {
#   zone_id = "aws_route53_zone.main.zone_id"
#   name    = "${var.name}-inbound.taskworld.com"
#   type    = "MX"
#   # ttl     = "300"
#   # records = ["${aws_eip.lb.public_ip}"]
# }


resource "aws_route53_record" "inbound" {
  # zone_id = "aws_route53_zone.main.zone_id"
  # zone_id = "Z2NWEC0UCQP63Q"
  zone_id = "Z1BRSAQJRYTCY8"
  name    = "${var.name}-inbound.dosthailand.com"
  type = "MX"
  ttl = "300"
  records = [
    "10 mx.sendgrid.net."
  ]
}


# terraform {
#   backend "s3" {
#     bucket = "tw-infraops"
#     key    = "terraform/vpc-state-us-east-2/terraform.tfstate"
#     region  = "ap-southeast-1"
#     encrypt = true
#   }
# }

# resource "aws_route53_zone" "main" {
#   name = "var.domain"
# }

variable "records" {
  default = ["admin", "admin-api", "backend", "public-api", "reply", "socket", "timeline-export", "sso"]
}

resource "aws_eip" "this" {
  vpc      = true
  instance = module.ec2.id[0]
}
