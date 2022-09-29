#____________________________________________________________
#
# SNMP Policy Variables Section.
#____________________________________________________________

variable "access_community_string" {
  default     = 0
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = number
}

variable "access_community_string_1" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_2" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_3" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_4" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "access_community_string_5" {
  default     = ""
  description = "The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long."
  sensitive   = true
  type        = string
}

variable "description" {
  default     = ""
  description = "Description for the Policy."
  type        = string
}

variable "domain_profiles" {
  default     = {}
  description = "Map for Moid based Domain Profile Sources."
  type        = any
}

variable "enable_snmp" {
  default     = true
  description = "State of the SNMP Policy on the endpoint. If enabled, the endpoint sends SNMP traps to the designated host."
  type        = bool
}

variable "moids" {
  default     = false
  description = "Flag to Determine if pools and policies should be data sources or if they already defined as a moid."
  type        = bool
}

variable "name" {
  default     = "default"
  description = "Name for the Policy."
  type        = string
}

variable "organization" {
  default     = "default"
  description = "Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/."
  type        = string
}

variable "profiles" {
  default     = []
  description = <<-EOT
    List of Profiles to Assign to the Policy.
    * name - Name of the Profile to Assign.
    * object_type - Object Type to Assign in the Profile Configuration.
      - chassis.Profile - For UCS Chassis Profiles.
      - fabric.SwitchProfile - For UCS Domain Switch Profiles.
      - server.Profile - For UCS Server Profiles.
      - server.ProfileTemplate - For UCS Server Profile Templates.
  EOT
  type = list(object(
    {
      name        = string
      object_type = optional(string, "server.Profile")
    }
  ))
}

variable "snmp_auth_password_1" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_2" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_3" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_4" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_5" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}

variable "snmp_community_access" {
  default     = "Full"
  description = <<-EOT
    Controls access to the information in the inventory tables. Applicable only for SNMPv1 and SNMPv2c users.
    * Disabled - Blocks access to the information in the inventory tables.
    * Full: (default) - Full access to read the information in the inventory tables.
    * Limited - Partial access to read the information in the inventory tables.
  EOT
  type        = string
}

variable "snmp_engine_input_id" {
  default     = ""
  description = "Unique string to identify the device for administration purpose. This is generated from the SNMP Input Engine ID if it is already defined, else it is derived from the BMC serial number."
  type        = string
}

variable "snmp_port" {
  default     = 161
  description = "Port on which Cisco IMC SNMP agent runs. Enter a value between 1-65535. Reserved ports not allowed (22, 23, 80, 123, 389, 443, 623, 636, 2068, 3268, 3269).  Default is 161."
  type        = number
}

variable "snmp_privacy_password_1" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_2" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_3" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_4" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_privacy_password_5" {
  default     = ""
  description = "SNMPv3 User Privacy Password."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_1" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_2" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_3" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_4" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_community_5" {
  default     = ""
  description = "Community for a Trap Destination."
  sensitive   = true
  type        = string
}

variable "snmp_trap_destinations" {
  default     = []
  description = <<-EOT
    List of SNMP Trap Destinations to Assign to the Policy.
    * community_string: (default is 0) -  A number Between 1-5 to denote to use one of the variables snmp_auth_password_[1-5].  Any other number means no community string.
    * enable: (default is true) - Enables/disables the trap on the server If enabled, trap is active on the server.
    * hostname: (required) - Hostname of the Trap Destination.
    * port: (default is 162) - Port used by the server to communicate with the trap destination. Enter a value between 1-65535. Reserved ports not allowed (22, 23, 80, 123, 389, 443, 623, 636, 2068, 3268, 3269).
    * user: (optional) - SNMP user for the trap. Applicable only to SNMPv3.
    * trap_type: (default is Trap) - Type of trap which decides whether to receive a notification when a trap is received at the destination.
      - Inform - Receive notifications when trap is sent to the destination. This option is valid only for SNMPv2.
      - Trap - Do not receive notifications when trap is sent to the destination.
  EOT
  type = list(object(
    {
      community_string = optional(string, 0)
      enable           = optional(bool, true)
      hostname         = string
      port             = optional(number, 162)
      user             = optional(string, "")
      trap_type        = optional(string, "Trap")
    }
  ))
}

variable "snmp_users" {
  default     = []
  description = <<-EOT
    List of SNMP Users to Assign to the SNMP Policy.
    * auth_password: (default is 1) - A number Between 1-5 to denote to use one of the variables snmp_auth_password_[1-5].  Any other number means no authentication password.
    * Authorization protocol for authenticating the user.  Currently Options are:
      - MD5
      - SHA: (default)
      Note: In the future these options will be added.
      - NA - Authentication protocol is not applicable.
      - SHA-224 - SHA-224 protocol is used to authenticate SNMP user.
      - SHA-256 - SHA-256 protocol is used to authenticate SNMP user.
      - SHA-384 - SHA-384 protocol is used to authenticate SNMP user.
      - SHA-512 - SHA-512 protocol is used to authenticate SNMP user.
    * privacy_password: (default is 0) - A number Between 1-5 to denote to use one of the variables snmp_privacy_password_[1-5].  Any other number means no Privacy password.
    * privacy_type - Privacy protocol for the user.
      - AES - AES privacy protocol is used for SNMP user.
      - DES - DES privacy protocol is used for SNMP user.
      - NA: (default) - Privacy protocol is not applicable.
    * security_level: (optional) - Security mechanism used for communication between agent and manager.
      - AuthNoPriv: (default) - The user requires an authorization password but not a privacy password.
      - AuthPriv - The user requires both an authorization password and a privacy password.
    * user: (required) - SNMP username to create.
  EOT
  type = list(object(
    {
      auth_password    = optional(number, 1)
      auth_type        = optional(string, "SHA")
      privacy_password = optional(number, 0)
      privacy_type     = optional(string, "NA")
      security_level   = optional(string, "AuthNoPriv")
      user             = string
    }
  ))
}

variable "system_contact" {
  default     = ""
  description = "Contact person responsible for the SNMP implementation. Enter a string up to 64 characters, such as an email address or a name and telephone number."
  type        = string
}

variable "system_location" {
  default     = ""
  description = "Location of host on which the SNMP agent (server) runs."
  type        = string
}

variable "tags" {
  default     = []
  description = "List of Tag Attributes to Assign to the Policy."
  type        = list(map(string))
}

variable "trap_community_string" {
  default     = ""
  description = "SNMP community group used for sending SNMP trap to other devices. Valid only for SNMPv2c."
  sensitive   = true
  type        = string
}
