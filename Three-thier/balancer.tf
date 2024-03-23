

// Public load balancer
resource "aws_lb" "my_lb" {
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lb_sg.id]
    subnets = [ aws_subnet.public_subnets_az1.id,aws_subnet.public_subnets_az2.id ]
}

resource "aws_lb_target_group" "my_lb_tg" {

    name = "aws-lb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.my-aws-vpc.id

   health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "my_lb_lister" {
    load_balancer_arn = aws_lb.my_lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
       type = "forward"
       target_group_arn = aws_lb_target_group.my_lb_tg.arn
    }
}

resource "aws_lb_target_group_attachment" "my_server_1" {
    # availability_zone = var.availability_zone[0]
    target_group_arn = aws_lb_target_group.my_lb_tg.arn
    target_id = aws_instance.web_server_1.id
  
}

resource "aws_lb_target_group_attachment" "my_server_2" {
    # availability_zone = var.availability_zone[1]
    target_group_arn = aws_lb_target_group.my_lb_tg.arn
    target_id = aws_instance.web_server_2.id
  
}