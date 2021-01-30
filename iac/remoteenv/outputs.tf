output "cluster_name" {
  value = "${var.stage}.${var.domain_name}"
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.cluster
}
output "kops_state_store" {
  value = "s3://${aws_s3_bucket.kops_state_store.id}"
}
