//--- loadbalancing/variables.tf --- //

variable "public_sg" {
    description = "This is var for LB security group"
}
variable "public_subnets" {
    description = "This is var for LB subnets"
}
variable "tg_port" {
    description = "This is var for LB TG port"
}
variable "tg_protocol" {
    description = "This is var for LB TG protocol"
}
variable "vpc_id" {
    description = "This is var for LB VPC"
}
variable "lb_healhty_threshold" {
    description = "This is var for LB Health check healhty threshold"
}
variable "lb_unhealthy_threshold" {
    description = "This is var for LB Health check unhealhty threshold"
}
variable "lb_timeout" {
    description = "This is var for LB Health check timeout"
}
variable "lb_interval" {
    description = "This is var for LB Health check interval"
}
variable "listener_port" {
    description = "This is var for LB listener Ports"
}
variable "listener_protocol" {
    description = "This is var for LB listener Protocol"
}