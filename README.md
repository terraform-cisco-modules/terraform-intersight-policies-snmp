<!-- BEGIN_TF_DOCS -->
# Terraform Intersight Policies - SNMP
Manages Intersight SNMP Policies

Location in GUI:
`Policies` » `Create Policy` » `SNMP`

## Example

### main.tf
```hcl
module "snmp" {
  source  = "terraform-cisco-modules/policies-snmp/intersight"
  version = ">= 1.0.1"

  description  = "default SNMP Policy."
  name         = "default"
  organization = "default"
  snmp_trap_destinations = [
    {
      hostname = "198.18.1.31"
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
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}

variable "snmp_auth_password_1" {
  default     = ""
  description = "SNMPv3 User Authentication Password."
  sensitive   = true
  type        = string
}
```

## Environment Variables

It is not supported to include sensitive variables in maps or lists.  snmp_traps and snmp_users are lists of object.  So we assign the passwords as a numerical value in the list of object and then that references the variable that has been set as sensitive.  This way the values can be protected in the state file.

Thus, The SNMP Module may require more Sensitive Variables because SNMP Policies include community strings and authorization and privilege passwords.  In our example the only sensitive value is the auth_password, which was set to `1`.

If we were to use communities or privilege passwords we would need to add variables for these as well.

Each type of these sensitive variables, shown in the table below, can have up to five variables: snmp_auth_password_[1-5], snmp_privacy_password_[1-5], and snmp_trap_community_[1-5]. Add them according to your need.

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with value of [your-api-key]
- Add variable secretkey with value of [your-secret-file-content]
- Add variable snmp_auth_password_1 with value of [your-auth-password]

### Linux
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkey=`cat <secret-key-file-location>`
export TF_VAR_snmp_auth_password_1=`cat <your-auth-password>`
```

### Windows
```bash
$env:TF_VAR_apikey="<your-api-key>"
$env:TF_VAR_secretkey="<secret-key-file-location>""
$env:TF_VAR_snmp_auth_password_1="<your-auth-password>""
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_access_community_string"></a> [access\_community\_string](#input\_access\_community\_string) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `number` | `0` | no |
| <a name="input_access_community_string_1"></a> [access\_community\_string\_1](#input\_access\_community\_string\_1) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_2"></a> [access\_community\_string\_2](#input\_access\_community\_string\_2) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_3"></a> [access\_community\_string\_3](#input\_access\_community\_string\_3) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_4"></a> [access\_community\_string\_4](#input\_access\_community\_string\_4) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_access_community_string_5"></a> [access\_community\_string\_5](#input\_access\_community\_string\_5) | The default SNMPv1, SNMPv2c community name or SNMPv3 username to include on any trap messages sent to the SNMP host. The name can be 18 characters long. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_domain_profiles"></a> [domain\_profiles](#input\_domain\_profiles) | Map for Moid based Domain Profile Sources. | `any` | `{}` | no |
| <a name="input_enable_snmp"></a> [enable\_snmp](#input\_enable\_snmp) | State of the SNMP Policy on the endpoint. If enabled, the endpoint sends SNMP traps to the designated host. | `bool` | `true` | no |
| <a name="input_moids"></a> [moids](#input\_moids) | Flag to Determine if pools and policies should be data sources or if they already defined as a moid. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of Profiles to Assign to the Policy.<br>* name - Name of the Profile to Assign.<br>* object\_type - Object Type to Assign in the Profile Configuration.<br>  - chassis.Profile - For UCS Chassis Profiles.<br>  - fabric.SwitchProfile - For UCS Domain Switch Profiles.<br>  - server.Profile - For UCS Server Profiles.<br>  - server.ProfileTemplate - For UCS Server Profile Templates. | <pre>list(object(<br>    {<br>      name        = string<br>      object_type = optional(string, "server.Profile")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_snmp_auth_password_1"></a> [snmp\_auth\_password\_1](#input\_snmp\_auth\_password\_1) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_2"></a> [snmp\_auth\_password\_2](#input\_snmp\_auth\_password\_2) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_3"></a> [snmp\_auth\_password\_3](#input\_snmp\_auth\_password\_3) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_4"></a> [snmp\_auth\_password\_4](#input\_snmp\_auth\_password\_4) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_auth_password_5"></a> [snmp\_auth\_password\_5](#input\_snmp\_auth\_password\_5) | SNMPv3 User Authentication Password. | `string` | `""` | no |
| <a name="input_snmp_community_access"></a> [snmp\_community\_access](#input\_snmp\_community\_access) | Controls access to the information in the inventory tables. Applicable only for SNMPv1 and SNMPv2c users.<br>* Disabled - Blocks access to the information in the inventory tables.<br>* Full: (default) - Full access to read the information in the inventory tables.<br>* Limited - Partial access to read the information in the inventory tables. | `string` | `"Full"` | no |
| <a name="input_snmp_engine_input_id"></a> [snmp\_engine\_input\_id](#input\_snmp\_engine\_input\_id) | Unique string to identify the device for administration purpose. This is generated from the SNMP Input Engine ID if it is already defined, else it is derived from the BMC serial number. | `string` | `""` | no |
| <a name="input_snmp_port"></a> [snmp\_port](#input\_snmp\_port) | Port on which Cisco IMC SNMP agent runs. Enter a value between 1-65535. Reserved ports not allowed (22, 23, 80, 123, 389, 443, 623, 636, 2068, 3268, 3269).  Default is 161. | `number` | `161` | no |
| <a name="input_snmp_privacy_password_1"></a> [snmp\_privacy\_password\_1](#input\_snmp\_privacy\_password\_1) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_2"></a> [snmp\_privacy\_password\_2](#input\_snmp\_privacy\_password\_2) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_3"></a> [snmp\_privacy\_password\_3](#input\_snmp\_privacy\_password\_3) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_4"></a> [snmp\_privacy\_password\_4](#input\_snmp\_privacy\_password\_4) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_privacy_password_5"></a> [snmp\_privacy\_password\_5](#input\_snmp\_privacy\_password\_5) | SNMPv3 User Privacy Password. | `string` | `""` | no |
| <a name="input_snmp_trap_community_1"></a> [snmp\_trap\_community\_1](#input\_snmp\_trap\_community\_1) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_2"></a> [snmp\_trap\_community\_2](#input\_snmp\_trap\_community\_2) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_3"></a> [snmp\_trap\_community\_3](#input\_snmp\_trap\_community\_3) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_4"></a> [snmp\_trap\_community\_4](#input\_snmp\_trap\_community\_4) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_community_5"></a> [snmp\_trap\_community\_5](#input\_snmp\_trap\_community\_5) | Community for a Trap Destination. | `string` | `""` | no |
| <a name="input_snmp_trap_destinations"></a> [snmp\_trap\_destinations](#input\_snmp\_trap\_destinations) | List of SNMP Trap Destinations to Assign to the Policy.<br>* community\_string: (default is 0) -  A number Between 1-5 to denote to use one of the variables snmp\_auth\_password\_[1-5].  Any other number means no community string.<br>* enable: (default is true) - Enables/disables the trap on the server If enabled, trap is active on the server.<br>* hostname: (required) - Hostname of the Trap Destination.<br>* port: (default is 162) - Port used by the server to communicate with the trap destination. Enter a value between 1-65535. Reserved ports not allowed (22, 23, 80, 123, 389, 443, 623, 636, 2068, 3268, 3269).<br>* user: (optional) - SNMP user for the trap. Applicable only to SNMPv3.<br>* trap\_type: (default is Trap) - Type of trap which decides whether to receive a notification when a trap is received at the destination.<br>  - Inform - Receive notifications when trap is sent to the destination. This option is valid only for SNMPv2.<br>  - Trap - Do not receive notifications when trap is sent to the destination. | <pre>list(object(<br>    {<br>      community_string = optional(string, 0)<br>      enable           = optional(bool, true)<br>      hostname         = string<br>      port             = optional(number, 162)<br>      user             = optional(string, "")<br>      trap_type        = optional(string, "Trap")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_snmp_users"></a> [snmp\_users](#input\_snmp\_users) | List of SNMP Users to Assign to the SNMP Policy.<br>* auth\_password: (default is 1) - A number Between 1-5 to denote to use one of the variables snmp\_auth\_password\_[1-5].  Any other number means no authentication password.<br>* Authorization protocol for authenticating the user.  Currently Options are:<br>  - MD5<br>  - SHA: (default)<br>  Note: In the future these options will be added.<br>  - NA - Authentication protocol is not applicable.<br>  - SHA-224 - SHA-224 protocol is used to authenticate SNMP user.<br>  - SHA-256 - SHA-256 protocol is used to authenticate SNMP user.<br>  - SHA-384 - SHA-384 protocol is used to authenticate SNMP user.<br>  - SHA-512 - SHA-512 protocol is used to authenticate SNMP user.<br>* privacy\_password: (default is 0) - A number Between 1-5 to denote to use one of the variables snmp\_privacy\_password\_[1-5].  Any other number means no Privacy password.<br>* privacy\_type - Privacy protocol for the user.<br>  - AES - AES privacy protocol is used for SNMP user.<br>  - DES - DES privacy protocol is used for SNMP user.<br>  - NA: (default) - Privacy protocol is not applicable.<br>* security\_level: (optional) - Security mechanism used for communication between agent and manager.<br>  - AuthNoPriv: (default) - The user requires an authorization password but not a privacy password.<br>  - AuthPriv - The user requires both an authorization password and a privacy password.<br>* user: (required) - SNMP username to create. | <pre>list(object(<br>    {<br>      auth_password    = optional(number, 1)<br>      auth_type        = optional(string, "SHA")<br>      privacy_password = optional(number, 0)<br>      privacy_type     = optional(string, "NA")<br>      security_level   = optional(string, "AuthNoPriv")<br>      user             = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_system_contact"></a> [system\_contact](#input\_system\_contact) | Contact person responsible for the SNMP implementation. Enter a string up to 64 characters, such as an email address or a name and telephone number. | `string` | `""` | no |
| <a name="input_system_location"></a> [system\_location](#input\_system\_location) | Location of host on which the SNMP agent (server) runs. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_trap_community_string"></a> [trap\_community\_string](#input\_trap\_community\_string) | SNMP community group used for sending SNMP trap to other devices. Valid only for SNMPv2c. | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | SNMP Policy Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_snmp_policy.snmp](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/snmp_policy) | resource |
| [intersight_chassis_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/chassis_profile) | data source |
| [intersight_fabric_switch_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_profile) | data source |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
| [intersight_server_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile) | data source |
| [intersight_server_profile_template.templates](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile_template) | data source |
<!-- END_TF_DOCS -->