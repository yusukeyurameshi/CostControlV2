# Cria o compartment
resource oci_identity_compartment CostControl {
  provider       = oci.home_region
  description    = "CostControl"
  name           = "CostControl"
  compartment_id = var.tenancy_ocid
}
