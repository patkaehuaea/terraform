provider "aws" {
  region = "us-west-1"
}

data "aws_ami" "unifi-controller" {
  most_recent = true

  # If we change the AWS Account in which test are run, update this value.
  owners = ["874011138780"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "is-public"
    values = ["false"]
  }

  filter {
    name   = "name"
    values = ["unifi-controller-ubuntu18*"]
  }
}

resource "aws_instance" "unifi-controller" {
  ami           = data.aws_ami.unifi-controller.id
  instance_type = "t2.nano"

  tags = {
    builder = "terraform"
  }
}
