# -----------------------------------------------------------------------------
# Definitions for VPC, subnets, and security groups to use
# -----------------------------------------------------------------------------

# Let's just operate in the default VPC for now...
# Note, I've already set up a VPC with a NAT gateway + public subnets!
data "aws_vpc" "default" {
  default = true
}

# And while we're at it, use the default subnets too!
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "allow_all_outbound" {
  name        = "all_all_outbound"
  description = "Allow all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
