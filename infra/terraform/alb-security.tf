resource "aws_vpc_security_group_ingress_rule" "alb_http_current_ip" {
  security_group_id = "sg-0c8b43c25da2b75cd"

  cidr_ipv4   = "223.238.158.125/32"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  description = "Allow HTTP from current public IP"
}