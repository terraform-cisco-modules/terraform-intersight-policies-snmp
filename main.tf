#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  name = var.organization
}

#____________________________________________________________
#
# Intersight UCS Chassis Profile(s) Data Source
# GUI Location: Profiles > UCS Chassis Profiles > {Name}
#____________________________________________________________

data "intersight_chassis_profile" "profiles" {
  for_each = { for v in local.profiles : v.name => v if v.object_type == "chassis.Profile" }
  name     = each.value.name
}

#____________________________________________________________
#
# Intersight UCS Domain Profile(s) Data Source
# GUI Location: Profiles > UCS Domain Profiles > {Name}
#____________________________________________________________

data "intersight_fabric_switch_profile" "profiles" {
  for_each = { for v in local.profiles : v => v if v.object_type == "fabric.SwitchProfile" }
  name     = each.value
}


#____________________________________________________________
#
# Intersight UCS Server Profile(s) Data Source
# GUI Location: Profiles > UCS Server Profiles > {Name}
#____________________________________________________________

data "intersight_server_profile" "profiles" {
  for_each = { for v in local.profiles : v.name => v if v.object_type == "server.Profile" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight UCS Server Profile Template(s) Data Source
# GUI Location: Templates > UCS Server Profile Templates > {Name}
#__________________________________________________________________

data "intersight_server_profile_template" "templates" {
  for_each = { for v in local.profiles : v.name => v if v.object_type == "server.ProfileTemplate" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight SNMP Policy
# GUI Location: Policies > Create Policy > SNMP
#__________________________________________________________________

resource "intersight_snmp_policy" "snmp" {
  depends_on = [
    data.intersight_chassis_profile.profiles,
    data.intersight_fabric_switch_profile.profiles,
    data.intersight_server_profile.profiles,
    data.intersight_server_profile_template.templates,
    data.intersight_organization_organization.org_moid
  ]
  access_community_string = var.access_community_string
  community_access        = var.snmp_community_access
  description             = var.description != "" ? var.description : "${var.name} SNMP Policy."
  enabled                 = var.enable_snmp
  engine_id               = var.snmp_engine_input_id
  name                    = var.name
  snmp_port               = var.snmp_port
  sys_contact             = var.system_contact
  sys_location            = var.system_location
  trap_community          = var.trap_community_string
  v2_enabled = length(compact([var.access_community_string])
    ) > 0 || length(compact([var.trap_community_string])
    ) > 0 || length(compact([var.snmp_trap_community_1])
    ) > 0 || length(compact([var.snmp_trap_community_2])
    ) > 0 || length(compact([var.snmp_trap_community_3])
    ) > 0 || length(compact([var.snmp_trap_community_4])
    ) > 0 || length(compact([var.snmp_trap_community_5])
  ) > 0 ? true : false
  v3_enabled = length(var.snmp_users) > 0 ? true : false
  organization {
    moid        = data.intersight_organization_organization.org_moid.results[0].moid
    object_type = "organization.Organization"
  }
  dynamic "profiles" {
    for_each = local.profiles
    content {
      moid = length(regexall("chassis.Profile", profiles.value.object_type)
        ) > 0 ? data.intersight_chassis_profile.profiles[profiles.value.name].results[0
        ].moid : length(regexall("fabric.SwitchProfile", profiles.value.object_type)
        ) > 0 ? data.intersight_fabric_switch_profile.profiles[profiles.value.name].results[0
        ].moid : length(regexall("server.ProfileTemplate", profiles.value.object_type)
        ) > 0 ? data.intersight_server_profile_template.templates[profiles.value.name].results[0
      ].moid : data.intersight_server_profile.profiles[profiles.value.name].results[0].moid
      object_type = profiles.value.object_type
    }
  }
  dynamic "snmp_traps" {
    for_each = { for v in var.snmp_trap_destinations : v.hostname => v }
    content {
      community = length(
        regexall("1", coalesce(snmp_traps.value.community_string, 10))
        ) > 0 ? var.snmp_trap_community_1 : length(
        regexall("2", coalesce(snmp_traps.value.community_string, 10))
        ) > 0 ? var.snmp_trap_community_2 : length(
        regexall("3", coalesce(snmp_traps.value.community_string, 10))
        ) > 0 ? var.snmp_trap_community_3 : length(
        regexall("4", coalesce(snmp_traps.value.community_string, 10))
        ) > 0 ? var.snmp_trap_community_4 : length(
        regexall("5", coalesce(snmp_traps.value.community_string, 10))
      ) > 0 ? var.snmp_trap_community_5 : ""
      destination = snmp_traps.value.hostname
      enabled     = snmp_traps.value.enable
      port        = snmp_traps.value.port
      type        = snmp_traps.value.trap_type
      nr_version  = length(compact([snmp_traps.value.user])) > 0 ? "V3" : "V2"
      user        = snmp_traps.value.user
    }
  }
  dynamic "snmp_users" {
    for_each = { for v in var.snmp_users : v.user => v }
    content {
      auth_password = length(
        regexall("1", coalesce(snmp_users.value.auth_password, 10))
        ) > 0 ? var.snmp_auth_password_1 : length(
        regexall("2", coalesce(snmp_users.value.auth_password, 10))
        ) > 0 ? var.snmp_auth_password_2 : length(
        regexall("3", coalesce(snmp_users.value.auth_password, 10))
        ) > 0 ? var.snmp_auth_password_3 : length(
        regexall("4", coalesce(snmp_users.value.auth_password, 10))
        ) > 0 ? var.snmp_auth_password_3 : length(
        regexall("5", coalesce(snmp_users.value.auth_password, 10))
      ) > 0 ? var.snmp_auth_password_5 : ""
      auth_type = snmp_users.value.auth_type
      name      = snmp_users.value.user
      privacy_password = length(
        regexall("1", coalesce(snmp_users.value.privacy_password, 10))
        ) > 0 ? var.snmp_privacy_password_1 : length(
        regexall("2", coalesce(snmp_users.value.privacy_password, 10))
        ) > 0 ? var.snmp_privacy_password_2 : length(
        regexall("3", coalesce(snmp_users.value.privacy_password, 10))
        ) > 0 ? var.snmp_privacy_password_3 : length(
        regexall("4", coalesce(snmp_users.value.privacy_password, 10))
        ) > 0 ? var.snmp_privacy_password_3 : length(
        regexall("5", coalesce(snmp_users.value.privacy_password, 10))
      ) > 0 ? var.snmp_privacy_password_5 : ""
      privacy_type   = snmp_users.value.privacy_type
      security_level = snmp_users.value.security_level
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
