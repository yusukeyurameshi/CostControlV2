resource oci_identity_compartment CostControl {
  description = "CostControl"
  name = "CostControl"
  compartment_id = var.compartment_ocid
}

resource oci_identity_dynamic_group DynCostControl {
  depends_on = [oci_core_instance.CostControl-inst]
  compartment_id = var.compartment_ocid
  description = "DynCostControl"
  matching_rule = join("",["ANY { instance.id = '" , oci_core_instance.CostControl-inst.id , "' }"])
  name = "DynCostControl"
}

resource oci_identity_policy PolCostControl {
  depends_on = [oci_identity_dynamic_group.DynCostControl]
  compartment_id = var.compartment_ocid
  description = "PolCostControl"
  name = "PolCostControl"
  statements = [
    "define tenancy usage-report as ocid1.tenancy.oc1..aaaaaaaaned4fkpkisbwjlr56u7cj63lf3wffbilvqknstgtvzub7vhqkggq",
    "endorse dynamic-group DynCostControl to read objects in tenancy usage-report",
    "Allow dynamic-group DynCostControl to inspect compartments in tenancy",
    "Allow dynamic-group DynCostControl to inspect tenancies in tenancy"
  ]
}

resource oci_core_vcn virtual_network {
  cidr_block     = "10.0.0.0/16"
  compartment_id = oci_identity_compartment.CostControl.id
  defined_tags   = {}

  display_name = "costcontrol_vcn"
  dns_label    = "costcontrol"
}

data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = oci_identity_compartment.CostControl.id
}

resource "oci_core_internet_gateway" "internet_gateway" {
  display_name   = "costcontrol-IGW"
  compartment_id = oci_identity_compartment.CostControl.id
  vcn_id         = oci_core_vcn.virtual_network.id
}

resource "oci_core_route_table" "route_table" {
  display_name   = "route_table"
  compartment_id = oci_identity_compartment.CostControl.id
  vcn_id         = oci_core_vcn.virtual_network.id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

resource "oci_core_security_list" "security_list" {
  display_name   = "security_list"
  compartment_id = oci_identity_compartment.CostControl.id
  vcn_id         = oci_core_vcn.virtual_network.id

  egress_security_rules {
    protocol    = "All"
    destination = "0.0.0.0/0"
  }

}

resource oci_core_subnet costcontrol_subnet_public {
  cidr_block     = "10.0.0.0/24"
  compartment_id = oci_identity_compartment.CostControl.id
  defined_tags   = {}

  dhcp_options_id = oci_core_vcn.virtual_network.default_dhcp_options_id
  display_name    = "PubSub"
  dns_label       = "costcontrol"

  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_route_table.route_table.id

  security_list_ids = [
    oci_core_security_list.security_list.id,
  ]

  vcn_id = oci_core_vcn.virtual_network.id
}
