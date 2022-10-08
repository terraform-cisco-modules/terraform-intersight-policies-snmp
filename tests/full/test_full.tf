module "main" {
  source               = "../.."
  description          = "${var.name} SNMP Policy."
  name                 = var.name
  organization         = "terratest"
  snmp_auth_password_1 = var.snmp_auth_password_1
  snmp_trap_destinations = [
    {
      hostname = "198.18.1.62"
      user     = "snmpuser"
    }
  ]
  snmp_users = [
    {
      auth_password = 1
      user          = "snmpuser"
    }
  ]
}

variable "snmp_auth_password_1" {
  sensitive = true
  type      = string
}