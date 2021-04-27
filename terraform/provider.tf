terraform {
  required_version = ">= 0.12.0"
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