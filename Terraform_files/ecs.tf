data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_ecs_cluster" "node_app_cluster" {
  name = "node-app-ecs-cluster"
}

# resource "aws_default_vpc" "default_vpc" {}

# resource "aws_default_subnet" "default_subnet_a" {
#   availability_zone = var.availability_zones[0]
# }

# resource "aws_default_subnet" "default_subnet_b" {
#   availability_zone = var.availability_zones[1]
# }

# resource "aws_default_subnet" "default_subnet_c" {
#   availability_zone = var.availability_zones[2]
# }

resource "aws_ecs_task_definition" "node_app_task" {
  family                   = "node-app-family-${random_string.task_suffix.result}"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "node-app",
      "image": "381491819482.dkr.ecr.us-east-1.amazonaws.com/nodeapp",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort":3000
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "node-app-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_alb" "application_load_balancer" {
  name               = "alb"
  load_balancer_type = "application"
  subnets = [
    data.aws_subnet.subnet1.id,
    data.aws_subnet.subnet2.id,
    data.aws_subnet.subnet4.id
  ]
  security_groups = [data.aws_security_group.sg.id]
}

resource "aws_lb_target_group" "target_group" {
  name        = "node-app-target-gro"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_ecs_service" "node_app_service" {
  name            = "node-app-service"
  cluster         = aws_ecs_cluster.node_app_cluster.id
  task_definition = aws_ecs_task_definition.node_app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
    depends_on = [ aws_ecs_task_definition.node_app_task ]
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "node-app"
    container_port   = 3000
  }

  network_configuration {
    subnets          = [data.aws_subnet.subnet1.id,data.aws_subnet.subnet2.id,data.aws_subnet.subnet4.id]
    assign_public_ip = true
    security_groups  = [data.aws_security_group.sg.id]
  }
}

# resource "aws_security_group" "service_security_group" {
#   ingress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }