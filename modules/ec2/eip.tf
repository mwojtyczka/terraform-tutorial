resource "aws_eip" "web" {
    vpc = true
    instance = aws_instance.web.id
}