output "arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The s3 bucket ARN"
}

output "name" {
  value       = aws_s3_bucket.bucket.id
  description = "The s3 bucket name"
}

output "uri" {
  value       = "s3://${aws_s3_bucket.bucket.id}"
  description = "URI of the S3 bucket"
}
