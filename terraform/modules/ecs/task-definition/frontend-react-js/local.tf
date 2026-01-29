locals {
  container_definitions_frontend = [
    {
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
    },
    {
      name      = "frontend-react-js"
      image     = "${var.ecr_repo}"
      essential = true

      portMappings = [
        {
          name          = "frontend-react-js"
          containerPort = 3000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      healthCheck = {
        command  = ["CMD-SHELL", "curl -f http://localhost:3000 || exit 1"]
        interval = 30
        timeout  = 5
        retries  = 3
      }

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group
          awslogs-region        = var.region
          awslogs-stream-prefix = "frontend-react-js"
        }
      }
    }
  ]
}