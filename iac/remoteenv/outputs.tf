output "cluster_name" {
  value = local.cluster_name
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "kops_state_store" {
  value = "s3://${aws_s3_bucket.kops_state_store.id}"
}

output "aws_region" {
  value = var.aws_region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}

output "nat_gateway_ids" {
  value = module.vpc.natgw_ids
}

output "k8s_api_http_security_group_id" {
  value = aws_security_group.k8s_api_http.id
}
