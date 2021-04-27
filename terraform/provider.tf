terraform {
  required_version = ">= 0.14"
}

provider "oci" {
  alias                = "homeregion"
#  tenancy_ocid         = var.tenancy_ocid
#  user_ocid            = var.user_ocid
#  fingerprint          = var.fingerprint
#  private_key_path     = var.private_key_path
  region               = data.oci_identity_region_subscriptions.home_region_subscriptions.region_subscriptions[0].region_name
  disable_auto_retries = "true"
}


# Required by the OCI Provider
variable compartment_ocid {}
variable region {}

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# The defaults here will give you a cluster.  You can also modify these.
# ---------------------------------------------------------------------------------------------------------------------
variable Instance_shape_free {default = "VM.Standard.E2.1.Micro"}
variable InstanceOS {default = "Oracle Linux"}
variable InstanceOSVersion {default = "7.9"}
variable cidr_block {default = "10.0.0.0/16"}
variable display_name {default = "costcontrol_vcn"}
variable dns_label {default = "costcontrol"}