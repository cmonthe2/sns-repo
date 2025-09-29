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
  protocol  = "email"
  endpoint  = "cmonthe8@outlook.com"
}

# Output the SNS Topic ARN
output "sns_topic_arn" {
  value = aws_sns_topic.my_topic.arn
}
resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "sms"
  endpoint  = "2408109458"
}
