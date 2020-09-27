#
# cloudws
# Autoscaling module
#

resource "aws_security_group" "instance_sg"  {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.exposed_ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "instance_template" {
  name_prefix = "${var.name_prefix}-"
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair
  security_groups = [aws_security_group.instance_sg.id]
  user_data = var.user_data

  # Ensure no disruptions when replacing resource
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "instance_asg" {
  name = "${var.name_prefix}-asg"
  min_size = var.min_scale
  max_size = var.max_scale
  launch_configuration = aws_launch_configuration.instance_template.name
  vpc_zone_identifier = [var.subnet_id]
  

  # Ensure no disruptions when replacing resource
  lifecycle {
    create_before_destroy = true
  }
}
