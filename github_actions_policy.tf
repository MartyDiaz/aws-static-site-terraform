#Permissions for the GitHub Actions role. The trust policy is in github_oidc.tf. IAM changes must be applied manually.

data "aws_iam_policy_document" "github_actions_permissions" {
  statement {
    sid     = "SiteBucket"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }

  statement {
    sid       = "StateBucketList"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.state_bucket_name}"]
  }

  statement {
    sid       = "StateObjects"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["arn:aws:s3:::${var.state_bucket_name}/static-site/*"]
  }

  statement {
    sid = "CloudFront"
    actions = [
      "cloudfront:*Distribution*",
      "cloudfront:*OriginAccessControl*",
      "cloudfront:TagResource",
      "cloudfront:UntagResource",
      "cloudfront:ListTagsForResource",
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations",
    ]
    resources = ["*"]
  }

  statement {
    sid = "ReadOwnRole"
    actions = [
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListRoleTags",
    ]
    resources = [aws_iam_role.github_actions.arn]
  }

  statement {
    sid = "ReadOidcProvider"
    actions = [
      "iam:GetOpenIDConnectProvider",
      "iam:ListOpenIDConnectProviderTags",
    ]
    resources = [aws_iam_openid_connect_provider.github.arn]
  }
}

resource "aws_iam_role_policy" "github_actions" {
  name   = "github-actions-terraform-permissions"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.github_actions_permissions.json
}
