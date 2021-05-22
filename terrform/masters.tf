resource "aws_instance" "okds" {
    ami = var.ami
    instance_type = var.okd_instance_type
    count = var.okd_count
    subnet_id = aws_subnet.public_subnet_a.id
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.okd.id ]
    key_name = aws_key_pair.cluster_key.key_name
    tags = merge(var.tags, { Name = format("%s-okd-${count.index + 1}", var.project_name) })
}

resource "aws_instance" "haproxys" {
    ami = var.ami
    instance_type = var.haproxy_instance_type
    count = var.haproxy_count
    subnet_id = aws_subnet.public_subnet_a.id
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.okd.id ]
    key_name = aws_key_pair.cluster_key.key_name
    tags = merge(var.tags, { Name = format("%s-haproxy-${count.index + 1}", var.project_name) })
}

output "public_ip_okd" {
  description = "lista o DNS publico da VPC"
  value       = aws_instance.okds.*.public_ip
}

output "private_ip_okd" {
  description = "lista o DNS publico da VPC"
  value       = aws_instance.okds.*.private_ip
}

output "public_ip_haproxy" {
  description = "lista o DNS publico da VPC"
  value       = aws_instance.haproxys.*.public_ip
}

output "private_ip_haproxys" {
  description = "lista o DNS publico da VPC"
  value       = aws_instance.haproxys.*.private_ip
}
