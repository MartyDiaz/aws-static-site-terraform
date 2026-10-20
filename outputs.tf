output "bucket_name" {
  description = "Name of the site bucket"
  value       = aws_s3_bucket.site.id
}

output "bucket_arn" {
  description = "ARN of the site bucket"
  value       = aws_s3_bucket.site.arn
}

output "cloudfront_domain_name" {
  description = "URL of the site"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "github_actions_role_arn" {
  description = "Role ARN for GitHub Actions to assume"
  value       = aws_iam_role.github_actions.arn
}