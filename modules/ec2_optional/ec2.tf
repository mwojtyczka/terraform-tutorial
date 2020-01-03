# Find the latest available Amazon Linux 2.0 AMI
data "aws_ami" "web" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }
  
  owners = ["amazon"]
  most_recent = true
}

resource "aws_instance" "web" {
  count = local.count

  ami = data.aws_ami.web.id

  instance_type = "t2.micro"
  
  tags = merge(
        # add additional tag to default tags
        map( 
            "Name", local.name,
        ), var.context.tags)
  
  user_data = templatefile("${path.module}/install_website.sh", {})

  vpc_security_group_ids = [ aws_security_group.allow_http[count.index].id ]
}

resource "aws_security_group" "allow_http" {
  count = local.count

  name        = "${local.name}-allow-http"
  description = "Allow http inbound traffic"
  tags = var.context.tags

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = -1 # all
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
