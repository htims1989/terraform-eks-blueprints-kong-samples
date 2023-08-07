locals {
  name   = basename(path.cwd)
  region = "us-west-2"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints-addons"
  }

  runtimeGroupData = jsondecode(data.http.konnect_runtime_group_api.response_body)

  konnect_base_hostname = "api.konghq.com"

  cluster_dns   = replace(local.runtimeGroupData.config.control_plane_endpoint, "https://", "")
  telemetry_dns = replace(local.runtimeGroupData.config.telemetry_endpoint, "https://", "")

  kic_apiHostname = "${var.konnect_region}.kic.${local.konnect_base_hostname}"
  apiHostname     = "${var.konnect_region}.${local.konnect_base_hostname}"
}
