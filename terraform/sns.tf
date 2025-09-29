# Create SNS Topic
resource "aws_sns_topic" "my_topic" {
  name = "my-notification-topic"
  tags = {
    Environment = "dev"
    Purpose     = "notifications"
  }
}

# Create SNS Topic Subscription
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "email"                # Can be: sqs, sms, lambda, email, etc.
  endpoint  = "cmonthe8@outlook.com" # Replace with your email address
}

# Optional: SNS Topic Policy
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.my_topic.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = [
          "SNS:Publish",
          "SNS:Subscribe"
        ]
        Resource = aws_sns_topic.my_topic.arn
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" : data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}
