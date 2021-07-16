terraform {
  required_providers {
    oci = {
      version = ">= 4.0.0"
    }
  }
}

locals {region_map = {for r in data.oci_identity_regions.regions.regions : r.key => r.name}}
provider "oci" {
  alias        = "home_region"
  region       = lookup(local.region_map, data.oci_identity_tenancy.tenancy.home_region_key)
  tenancy_ocid = var.tenancy_ocid
}

provider "oci" {
  region       = var.region
  tenancy_ocid = var.tenancy_ocid
}
