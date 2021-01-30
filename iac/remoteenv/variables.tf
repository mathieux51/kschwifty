variable "stage" {
  type        = string
  description = "development or production"
}

variable "aws_region" {
  type        = string
  description = "https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html"
  default     = "eu-central-1"
}

variable "domain_name" {
  type        = string
  description = "https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar.html"
  default     = "kschwifty.com"
}
