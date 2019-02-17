resource "aws_ecs_task_definition" "kong" {
  family                = "${var.app_name}"
  network_mode          = "awsvpc"
  container_definitions = <<EOF
[
  {
    "name": "${var.app_name}",
    "container_name": "${var.app_name}",
    "image": "${var.app_image}",
    "memoryReservation": ${var.container_memory_reservation},
    "portMappings": [
      {
        "ContainerPort": ${var.kong_port_http},
        "Protocol": "tcp"
      },
      {
        "ContainerPort": ${var.kong_port_https},
        "Protocol": "tcp"
      },
      {
        "ContainerPort": ${var.kong_port_admin},
        "Protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name"  : "KONG_ADMIN_LISTEN",
        "value" : "0.0.0.0:${var.kong_port_admin}"
      },
      {
        "name"  : "SSM_PARAMETER_NAME_DB_USERNAME",
        "value" : "${local.ssm_parameter_name_db_username}"
      },
      {
        "name"  : "SSM_PARAMETER_NAME_DB_PASSWORD",
        "value" : "${local.ssm_parameter_name_db_password}"
      },
      {
        "name"  : "SSM_PARAMETER_NAME_DB_ENGINE",
        "value" : "${local.ssm_parameter_name_db_engine}"
      },
      {
        "name"  : "SSM_PARAMETER_NAME_DB_HOST",
        "value" : "${local.ssm_parameter_name_db_host}"
      }
    ]
  }
]
EOF
}