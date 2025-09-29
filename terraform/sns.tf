# Create SNS Topic
resource "aws_sns_topic" "my_topic" {
  name = "my-notification-topic"
  tags = {
    Environment = "dev"
    Purpose     = "notifications"
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn                       = "arn:aws:sns:us-east-1:204469479814:Default_CloudWatch_Alarms_Topic"
  protocol                        = "email"
  endpoint                        = "cmonthe8@outlook.com"
  confirmation_timeout_in_minutes = 1
  raw_message_delivery            = false
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

resource "aws_sns_topic" "Default_CloudWatch_Alarms_Topic" {
  name = "Default_CloudWatch_Alarms_Topic"

  lifecycle {
    ignore_changes = [tags]
  }
}
