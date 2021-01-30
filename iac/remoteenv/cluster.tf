data "aws_availability_zones" "cluster" {
  state = "available"
}

resource "aws_route53_zone" "cluster" {
  name = var.domain_name
}

resource "aws_acm_certificate" "cluster" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = {
    Name : var.domain_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cluster" {
  for_each = {
    for dvo in aws_acm_certificate.cluster.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = aws_route53_zone.cluster.zone_id
}

# wait for validation
resource "aws_acm_certificate_validation" "cluster" {
  certificate_arn         = aws_acm_certificate.cluster.arn
  validation_record_fqdns = [for record in aws_route53_record.cluster : record.fqdn]
}

resource "aws_s3_bucket" "kops_state_store" {
  bucket = "kschwifty-kops-state-${var.stage}"
  acl           = "private"
  force_destroy = true

  # versioning {
  #   enabled = true
  # }
}
