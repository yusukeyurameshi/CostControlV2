resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
}

resource oci_core_vcn virtual_network {
  cidr_block     = var.cidr_block
  compartment_id = oci_identity_compartment.CostControl.id
  display_name   = var.display_name
  dns_label      = var.dns_label
  depends_on     = [
    oci_identity_compartment.CostControl,
    time_sleep.wait_30_seconds
  ]
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
  cidr_block                 = "10.0.0.0/24"
  compartment_id             = oci_identity_compartment.CostControl.id
  defined_tags               = {}
  dhcp_options_id            = oci_core_vcn.virtual_network.default_dhcp_options_id
  display_name               = "PubSub"
  dns_label                  = "costcontrol"
  vcn_id                     = oci_core_vcn.virtual_network.id
  route_table_id             = oci_core_route_table.route_table.id
  prohibit_public_ip_on_vnic = "false"
  security_list_ids = [
    oci_core_security_list.security_list.id,
  ]
}
