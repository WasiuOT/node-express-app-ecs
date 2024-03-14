# variable "REGION" {
#     default = "us-east-1"  
# }

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-07d9b9ddc6cd8dd30"
        us-east-2 = "ami-0f5daaa3a7fb3378b"
        
    }
}

variable "PRIV_KEY_PATH" {
    default = "nodeapp-key"
}

variable "PUB_KEY_PATH" {
    default = "nodeapp-key.pub"
}

variable "USERNAME" {
    default = "ubuntu"
}

variable "MYIP" {
    default = "100.6.167.17/32"  
}

variable dbuser {
  default = "admin"
}

variable dbpass {
  default = "admin123"
}

variable dbname {
  default = "accounts"
}

variable instance_count {
  default = "1"
}

variable VPC_NAME {
  default = "nodeapp-VPC"
}

variable Zone1 {
  default = "us-east-1a"
}

variable Zone2 {
  default = "us-east-1b"
}

variable VpcCIDR {
  default = "172.21.0.0/16"
}

variable PubSub1CIDR {
  default = "172.21.1.0/24"
}

variable PubSub2CIDR {
  default = "172.21.2.0/24"
}

variable PrivSub1CIDR {
  default = "172.21.4.0/24"
}

variable PrivSub2CIDR {
  default = "172.21.5.0/24"
}
