
variable "aws_profile" {
    description = "profile aws"
    default     = "default"
}

variable "project_name" {
    description = "Cluster Name"
    default     = "OKD"
}

variable "ami" {
    description = "Centos7"
    default = "ami-00e87074e52e6c9f9"
}

variable "aws_region" {
    description = "AWS Region for the VPC"
    default     = "us-east-1"
}

variable "aws_key_path" {
    description = "key_path"
    default     = "/home/lpgomes/.ssh/id_rsa_volta.pub"
}

variable "tags" {
    default = {
        project     = "Openshift Origin 3.11"
        enviroment  = "prod"
        version     = "3.11"
        vendor      = "Redhat"
    }
}

variable "okd_instance_type" {
    description = "OKD instance type"
    default     = "t2.medium"
}

variable "okd_count" {
    description = "RedHat OKD"
    default     = 5
}

variable "haproxy_count" {
    description = "HAPROXY OKD"
    default     = 1
}

variable "haproxy_instance_type" {
    description = "OKD instance type"
    default     = "t2.medium"
}
