output "my_intance" {
    value = aws_instance.my_instance[count.index]
}
