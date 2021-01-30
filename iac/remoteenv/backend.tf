resource "aws_dynamodb_table" "remoteenv_locks" {
  name         = "kschwifty-remoteenv-locks-${var.stage}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "customer_and_catalog_lambda_state" {
  bucket = "kschwifty-remoteenv-state-${var.stage}"
  force_destroy = true
  # versioning {
  #   enabled = true
  # }
}
