### Compute ###
# Gets the OCID of the OS image to use
data "oci_core_images" "OLImageOCID" {
  compartment_id = var.compartment_ocid
  operating_system = var.InstanceOS
  operating_system_version = var.InstanceOSVersion

  filter {
    name   = "display_name"
    values = ["^.*${var.InstanceOSVersion}-[^G].*$"] # FIXME: ["^((?!GPU).)*$"]
    regex  = true
  }

}

data oci_core_instances instances{
  compartment_id = var.compartment_ocid
  availability_domain = lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[0],"name")
}