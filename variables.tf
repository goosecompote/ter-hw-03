variable "service_account_key_file" { type = string }
variable "cloud_id" { type = string }
variable "folder_id" { type = string }

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
}

variable "each_vm" {
  type = list(object({
    vm_name       = string
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
}

variable "security_group_ingress" {
  description = "Ingress rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    { protocol = "TCP", description = "SSH", v4_cidr_blocks = ["0.0.0.0/0"], port = 22 },
    { protocol = "TCP", description = "HTTP", v4_cidr_blocks = ["0.0.0.0/0"], port = 80 },
    { protocol = "TCP", description = "HTTPS", v4_cidr_blocks = ["0.0.0.0/0"], port = 443 },
  ]
}

variable "security_group_egress" {
  description = "Egress rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    { protocol = "TCP", description = "All outbound", v4_cidr_blocks = ["0.0.0.0/0"], from_port = 0, to_port = 65365 }
  ]
}
