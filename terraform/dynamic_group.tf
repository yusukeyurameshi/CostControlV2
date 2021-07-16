resource "oci_identity_dynamic_group" "DynCostControl" {
  depends_on = [oci_core_instance.CostControl-inst]
  compartment_id = var.tenancy_ocid
  description = "DynCostControl"
  matching_rule = join("",["ANY { instance.id = '" , oci_core_instance.CostControl-inst.id , "' }"])
  name = "DynCostControl"
}

resource "oci_identity_policy" "PolCostControl" {
  depends_on = [oci_identity_dynamic_group.DynCostControl]
  compartment_id = var.tenancy_ocid
  description = "PolCostControl"
  name = "PolCostControl"
  statements = [
    "define tenancy usage-report as ocid1.tenancy.oc1..aaaaaaaaned4fkpkisbwjlr56u7cj63lf3wffbilvqknstgtvzub7vhqkggq",
    "endorse dynamic-group DynCostControl to read objects in tenancy usage-report",
    "Allow dynamic-group DynCostControl to inspect compartments in tenancy",
    "Allow dynamic-group DynCostControl to inspect tenancies in tenancy"
  ]
}
