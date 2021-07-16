# Required by the OCI Provider
variable "tenancy_ocid" {}
variable "region" {}

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# ---------------------------------------------------------------------------------------------------------------------
variable cidr_block {default = "10.0.0.0/16"}
variable dns_label {default = "costcontrol"}
variable display_name {default = "costcontrol_vcn"}

variable Instance_shape_free {default = "VM.Standard.E2.1.Micro"}
variable InstanceOSVersion {default = "7.9"}
variable InstanceOS {default = "Oracle Linux"}
