output "namespace" {
  value = var.namespace_name
}

output "deployment" {
  value = kubernetes_deployment.this
}

output "service" {
  value = kubernetes_service.this
}

output "service_account" {
  value = kubernetes_service_account.this
}

output "cluster_role" {
  value = kubernetes_cluster_role.this
}

output "cluster_role_binding" {
  value = kubernetes_cluster_role_binding.this
}

output "role" {
  value = kubernetes_role.this
}

output "role_binding" {
  value = kubernetes_role_binding.this
}

output "config_map_nginx_configuration" {
  value = kubernetes_config_map.nginx_configuration
}

output "config_map_tcp_services" {
  value = kubernetes_config_map.tcp_services
}

output "config_map_udp_services" {
  value = kubernetes_config_map.udp_services
}

output "load_balancer_ingress" {
  description = "List of ingress points for the load-balancer."
  value = kubernetes_service.this.load_balancer_ingress
}

output "ingress_class" {
  description = "Ingress-class to be used by this ingress controller."
  value = kubernetes_deployment.this.metadata.0.annotations.configuration_ingress_class
}

output "annotation_prefix" {
  description = "Annotation prefix to be used by this ingress controller."
  value = kubernetes_deployment.this.metadata.0.annotations.configuration_annotation_prefix
}
