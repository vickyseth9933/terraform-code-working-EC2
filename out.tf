##to get output when resource created successfully

##resource "aws_vpc" "my-vpc"

output "vpc-resource1" {
  value = aws_vpc.my-vpc.tags
}

output "vpc-resources2" {
  value = aws_vpc.my-vpc.id
}
output "vpc-resources3" {
  value = aws_vpc.my-vpc.arn
}
