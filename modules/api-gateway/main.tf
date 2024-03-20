provider "aws" {
  region = var.region
}

resource "aws_apigatewayv2_api" "main" {
  name          = "main"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.main.id

  name        = "$default"
  auto_deploy = true
}


resource "aws_security_group" "vpc_link" {
  name   = "vpc-link"
  vpc_id = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_apigatewayv2_vpc_link" "eks" {
  name                  = "eks"
  security_group_ids    = [aws_security_group.vpc_link.id]
  subnet_ids            = var.subnet_ids
}

data "aws_lb" "load_balancers" {
}

data "aws_lb_listener" "totem_eks_listener" {
    // Obtém o último load balance criado
    load_balancer_arn = element(data.aws_lb.load_balancers[*].arn, length(data.aws_lb.load_balancers[*].arn) - 1)
    port              = 8080
}

locals {
  listener_arn = data.aws_lb_listener.totem_eks_listener.arn
  alb_arn  = element(data.aws_lb.load_balancers[*].arn, length(data.aws_lb.load_balancers[*].arn) - 1)
}

resource "aws_apigatewayv2_integration" "eks" {
  api_id = aws_apigatewayv2_api.main.id

  integration_uri    = local.listener_arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.eks.id
}

resource "aws_apigatewayv2_route" "resource_default" {
  api_id = aws_apigatewayv2_api.main.id

  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.eks.id}"
}

output "hello_base_url" {
  value = "${aws_apigatewayv2_stage.default.invoke_url}/echo"
}