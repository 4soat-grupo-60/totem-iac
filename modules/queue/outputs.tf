output "order_queue_url" {
  description = "The URL of the order queue"
  value       = aws_sqs_queue.order_queue.id
}

output "order_queue_compensation_url" {
  description = "The URL of the order queue compensation"
  value       = aws_sqs_queue.order_queue_compensation.id
}

output "customer_queue_url" {
  description = "The URL of the customer queue"
  value       = aws_sqs_queue.customer_queue.id
}

output "payment_queue_url" {
  description = "The URL of the payment queue"
  value       = aws_sqs_queue.payment_queue.id
}

output "payment_queue_compensation_url" {
  description = "The URL of the payment queue compensation"
  value       = aws_sqs_queue.payment_queue_compensation.id
}