package test

import (
	"fmt"
	"os"
	"testing"

	iassert "github.com/cgascoig/intersight-simple-go/assert"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestFull(t *testing.T) {
	//========================================================================
	// Setup Terraform options
	//========================================================================

	// Generate a unique name for objects created in this test to ensure we don't
	// have collisions with stale objects
	uniqueId := random.UniqueId()
	instanceName := fmt.Sprintf("test-policies-snmp-%s", uniqueId)

	// Input variables for the TF module
	vars := map[string]interface{}{
		"apikey":               os.Getenv("IS_KEYID"),
		"secretkeyfile":        os.Getenv("IS_KEYFILE"),
		"snmp_auth_password_1": os.Getenv("SNMP_PASSWORD"),
		"name":                 instanceName,
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./full",
		Vars:         vars,
	})

	//========================================================================
	// Init and apply terraform module
	//========================================================================
	defer terraform.Destroy(t, terraformOptions) // defer to ensure that TF destroy happens automatically after tests are completed
	terraform.InitAndApply(t, terraformOptions)
	moid := terraform.Output(t, terraformOptions, "moid")
	assert.NotEmpty(t, moid, "TF module moid output should not be empty")

	//========================================================================
	// Make Intersight API call(s) to validate module worked
	//========================================================================

	// Setup the expected values of the returned MO.
	// This is a Go template for the JSON object, so template variables can be used
	expectedJSONTemplate := `
{
	"Name":        "{{ .name }}",
	"Description": "{{ .name }} SNMP Policy.",

	"CommunityAccess": "Full",
	"Enabled": true,
	"EngineId": "",
	"SnmpPort": 161,
	"SnmpTraps": [
	  {
		"ClassId": "snmp.Trap",
		"Community": "",
		"Destination": "198.18.1.62",
		"Enabled": true,
		"ObjectType": "snmp.Trap",
		"Port": 162,
		"SecurityLevel": "AuthPriv",
		"Type": "Trap",
		"User": "snmpuser",
		"Version": "V3",
		"VrfName": ""
	  }
	],
	"SnmpUsers": [
	  {
		"AuthType": "SHA",
		"ClassId": "snmp.User",
		"IsAuthPasswordSet": true,
		"IsPrivacyPasswordSet": false,
		"Name": "snmpuser",
		"ObjectType": "snmp.User",
		"PrivacyType": "NA",
		"SecurityLevel": "AuthNoPriv"
	  }
	],
	"SysContact": "",
	"SysLocation": "",
	"Tags": [],
	"TrapCommunity": "",
	"V2Enabled": false,
	"V3Enabled": true
}
`
	// Validate that what is in the Intersight API matches the expected
	// The AssertMOComply function only checks that what is expected is in the result. Extra fields in the
	// result are ignored. This means we don't have to worry about things that aren't known in advance (e.g.
	// Moids, timestamps, etc)
	iassert.AssertMOComply(t, fmt.Sprintf("/api/v1/snmp/Policies/%s", moid), expectedJSONTemplate, vars)
}
