module "snmp" {
  source  = "terraform-cisco-modules/policies-snmp/intersight"
  version = ">= 1.0.1"

  description  = "default SNMP Policy."
  name         = "default"
  organization = "default"
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
