# Find the latest available Amazon Linux 2.0 AMI
data "aws_ami" "web" {
  filter {
    name   = "state"
    values = ["available"]
  }

  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }
  
  owners = ["amazon"]
  most_recent = true
}

resource "aws_instance" "web" {
  ami = data.aws_ami.web.id
  # or use hardcoded map
  # ami = var.amis[var.context.region]
  instance_type = "t2.micro"
  
  tags = merge(
        # add additional tag to default tags
        map( 
            "Name", local.name,
        ), var.context.tags)
  
  user_data = templatefile("${path.module}/install_website.sh", {})

  vpc_security_group_ids = [ aws_security_group.allow_http.id ]
  
  # execute command on the local machine (machine running terraform apply)
  provisioner "local-exec" {
    command = "echo ${local.name}:${aws_instance.web.public_ip} > ip_address.txt"
  }
}

resource "aws_security_group" "allow_http" {
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

# execute command on the local machine (machine running terraform apply)
#resource "null_resource" "nullresource" {
#  provisioner "local-exec" {
#    command = "echo ${local.name}:${aws_instance.web.public_ip} > ip_address2.txt"
#  }
#}