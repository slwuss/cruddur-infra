locals {
  backend_container = {
    name      = "backend-flask"
    image     = "${var.ecr_repo}"
    essential = true

    portMappings = [
      {
        name          = "backend-flask"
        containerPort = 4567
        protocol      = "tcp"
        appProtocol   = "http"
      }
    ]

    healthCheck = {
      command     = ["CMD-SHELL", "python /backend-flask/script/flask/health-check"]
      interval    = 30
      timeout     = 5
      retries     = 3
      startPeriod = 60
    }

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = var.log_group
        awslogs-region        = var.region
        awslogs-stream-prefix = "backend-flask"
      }
    }

    environment = [
      { name = "OTEL_SERVICE_NAME", value = "backend-flask" },
      { name = "OTEL_EXPORTER_OTLP_ENDPOINT", value = "https://api.honeycomb.io" },
      { name = "FRONTEND_URL", value = var.frontend_url },
      { name = "BACKEND_URL", value = var.backend_url },
      { name = "AWS_DEFAULT_REGION", value = var.region },
      { name = "REGION", value = var.region },
      { name = "COGNITO_REGION", value = var.region },
      { name = "AWS_COGNITO_USER_POOL_ID", value = var.cognito_user_pool_id },
      { name = "AWS_COGNITO_USER_POOL_CLIENT_ID", value = var.cognito_user_pool_client_id },
      { name = "COGNITO_USER_POOL_ID", value = var.cognito_user_pool_id },
      { name = "COGNITO_USER_POOL_CLIENT_ID", value = var.cognito_user_pool_client_id }
    ]

    secrets = [
      { name = "AWS_ACCESS_KEY_ID", valueFrom = var.ssm_aws_access_key_id },
      { name = "AWS_SECRET_ACCESS_KEY", valueFrom = var.ssm_aws_secret_access_key },
      { name = "CONNECTION_URL", valueFrom = var.ssm_connection_url },
      { name = "OTEL_EXPORTER_OTLP_HEADERS", valueFrom = var.ssm_otel_headers }
    ]
  }

  xray_container = {
    name      = "xray"
    image     = "public.ecr.aws/xray/aws-xray-daemon"
    essential = true
    user      = "1337"

    portMappings = [
      {
        name          = "xray"
        containerPort = 2000
        protocol      = "udp"
      }
    ]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = var.log_group
        awslogs-region        = var.region
        awslogs-stream-prefix = "xray"
      }
    }
  }

  container_definitions_backend_flask = concat(
    [local.backend_container],
    var.enable_xray ? [local.xray_container] : []
  )
}