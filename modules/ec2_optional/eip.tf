resource "aws_eip" "web" {
    count = local.count

    vpc = true
    instance = aws_instance.web[count.index].id
}