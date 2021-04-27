resource "oci_core_instance" "CostControl-inst" {
  display_name        = "CostControl"
  compartment_id      = oci_identity_compartment.CostControl.id
  availability_domain = lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[0],"name")
  shape               = var.Instance_shape_free

  source_details {
    source_id   = lookup(data.oci_core_images.OLImageOCID.images[0], "id")
    source_type = "image"
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.costcontrol_subnet_public.id
    hostname_label   = "CostControl"
    assign_public_ip = "true"
  }

  metadata = {
    user_data = base64encode(file("./cloud-init/cloud-init.sh"))
  }

}
