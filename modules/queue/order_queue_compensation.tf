resource "aws_sqs_queue" "order_queue_compensation" {
  name                      = "order-queue-compensation"
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
}
