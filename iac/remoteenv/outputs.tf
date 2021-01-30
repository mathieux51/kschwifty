output "cluster_name" {
  value = "${var.stage}.${var.domain_name}"
}

output "availability_zones" {
  value = join(",", data.aws_availability_zones.cluster.names)
}
output "kops_state_store" {
  value = "s3://${aws_s3_bucket.kops_state_store.id}"
}
