variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = any

    default = [
       {
            protocol                  = "tcp"
            from_port                 = 80
            to_port                   = 80
            cidr_blocks               = ["0.0.0.0/0"]
            description               = "http"
        },
        {
            protocol                  = "tcp"
            from_port                 = 443
            to_port                   = 443
            cidr_blocks               = ["0.0.0.0/0"]
            description               = "https"
        },
        {
            protocol                  = "tcp"
            from_port                 = 22
            to_port                   = 22
            cidr_blocks               = ["0.0.0.0/0"]
            description               = "ssh"
        },
        {
            protocol                  = "icmp"
            from_port                 = -1
            to_port                   = -1 
            cidr_blocks               = ["0.0.0.0/0"]
            description               = "ping"
        }
   
    ]
}



