# Lista de availability domains do tenancy
data "oci_identity_availability_domains" "ad" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
}

# Faz uma query para identificar em qual AD esta liberado o limit do shape micro.
data "oci_limits_services" "compute" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  filter {
    name   = "name"
    values = ["compute"]
  }
}

data "oci_limits_limit_values" "shape_free" {
  provider       = oci.home_region
  compartment_id = var.tenancy_ocid
  service_name = data.oci_limits_services.compute.services[0].name
  scope_type = "AD"
  filter {
    name   = "value"
    regex  = true
    values = ["^[1-9]\\d*$"]
  }
  filter {
    name   = "name"
    regex  = true
    values = [lower(var.Instance_shape_free)]
  }
}

// Consulta a ultima versao disponivel da image Oracle Linux.
data "oci_core_images" "oracle_linux" {
  provider                 = oci.home_region
  compartment_id           = var.tenancy_ocid
  operating_system         = var.InstanceOS
  operating_system_version = var.InstanceOSVersion
  shape                    = var.Instance_shape_free
  filter {
    name   = "display_name"
    values = ["Oracle-Linux-7.9-2021.05.12-0"]
  }
}

# Data sourcers para identificar a home region do tenancy
data oci_identity_regions regions {}
data oci_identity_tenancy tenancy {
  tenancy_id = var.tenancy_ocid
}
