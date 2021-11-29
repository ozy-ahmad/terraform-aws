// --- networking/outputs.tf --- //

output "vpc_id" {
    value = aws_vpc.ozy_vpc.id
}