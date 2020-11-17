# RANDOMS
resource "random_string" "selector" {
  special = false
  upper = false
  number = false
  length = 8
}


# LOCALS
locals {
  annotations = {}
  labels = {
    "name" = "nginx-ingress-controller"
    "component" = "controller"
    "version" = var.image_version
    "part-of" = "ingress"
    "managed-by" = "terraform"
  }
  controller_port = 10254
}


# CONFIG MAPS
resource "kubernetes_config_map" "nginx_configuration" {
  metadata {
    name = var.nginx_configuration_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.config_map_annotations,
      var.nginx_configuration_annotations
    )
    labels = merge(
      {
        "instance" = var.nginx_configuration_name
      },
      local.labels,
      var.labels,
      var.config_map_labels,
      var.nginx_configuration_labels
    )
  }

  data = var.nginx_configuration_data
}

resource "kubernetes_config_map" "tcp_services" {
  metadata {
    name = var.tcp_services_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.config_map_annotations,
      var.tcp_services_annotations
    )
    labels = merge(
      {
        "instance" = var.tcp_services_name
      },
      local.labels,
      var.labels,
      var.config_map_labels,
      var.tcp_services_labels
    )
  }

  data = var.tcp_services_data
}

resource "kubernetes_config_map" "udp_services" {
  metadata {
    name = var.udp_services_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.config_map_annotations,
      var.udp_services_annotations
    )
    labels = merge(
      {
        "instance" = var.udp_services_name
      },
      local.labels,
      var.labels,
      var.config_map_labels,
      var.udp_services_labels
    )
  }

  data = var.udp_services_data
}


# SERVICE ACCOUNT
resource "kubernetes_service_account" "this" {
  metadata {
    name = var.service_account_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.service_account_annotations
    )
    labels = merge(
      {
        "instance" = var.service_account_name
      },
      local.labels,
      var.labels,
      var.service_account_labels
    )
  }

  automount_service_account_token = true
}


# CLUSTER ROLE
resource "kubernetes_cluster_role" "this" {
  metadata {
    name = var.cluster_role_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.cluster_role_annotations
    )
    labels = merge(
      {
        "instance" = var.cluster_role_name
      },
      local.labels,
      var.labels,
      var.cluster_role_labels
    )
  }

  rule {
    api_groups = [""]
    resources = ["configmaps", "endpoints", "nodes", "pods", "secrets"]
    verbs = ["list", "watch"]
  }

  rule {
    api_groups = [""]
    resources = ["nodes"]
    verbs = ["get"]
  }

  rule {
    api_groups = [""]
    resources = ["services"]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources = ["events"]
    verbs = ["create", "patch"]
  }

  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources = ["ingresses"]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources = ["ingresses/status"]
    verbs = ["update"]
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = var.cluster_role_binding_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.cluster_role_binding_annotations
    )
    labels = merge(
      {
        "instance" = var.cluster_role_binding_name
      },
      local.labels,
      var.labels,
      var.cluster_role_binding_labels
    )
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = kubernetes_cluster_role.this.metadata.0.name
  }

  subject {
    api_group = ""
    kind = "ServiceAccount"
    name = kubernetes_service_account.this.metadata.0.name
    namespace = var.namespace_name
  }
}


# ROLE
resource "kubernetes_role" "this" {
  metadata {
    name = var.role_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.role_annotations
    )
    labels = merge(
      {
        "instance" = var.role_name
      },
      local.labels,
      var.labels,
      var.role_labels
    )
  }

  rule {
    api_groups = [""]
    resources = ["configmaps", "pods", "secrets", "namespaces"]
    verbs = ["get"]
  }

  rule {
    api_groups = [""]
    resources = ["configmaps"]
    resource_names = ["${var.election_id}-${var.ingress_class}"]
    verbs = ["get", "update"]
  }

  rule {
    api_groups = [""]
    resources = ["configmaps"]
    verbs = ["create"]
  }

  rule {
    api_groups = [""]
    resources = ["endpoints"]
    verbs = ["get"]
  }
}

resource "kubernetes_role_binding" "this" {
  metadata {
    name = var.role_binding_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.role_binding_annotations
    )
    labels = merge(
      {
        "instance" = var.role_binding_name
      },
      local.labels,
      var.labels,
      var.role_binding_labels
    )
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "Role"
    name = kubernetes_role.this.metadata.0.name
  }

  subject {
    api_group = ""
    kind = "ServiceAccount"
    name = kubernetes_service_account.this.metadata.0.name
    namespace = var.namespace_name
  }
}


# DEPLOYMENTS
resource "kubernetes_deployment" "this" {
  metadata {
    name = var.deployment_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.deployment_annotations,
      {
        "configuration_annotation_prefix" = var.annotations_prefix
        "configuration_ingress_class" = var.ingress_class
      },
    )
    labels = merge(
      {
        "instance" = var.deployment_name
      },
      local.labels,
      var.labels,
      var.deployment_labels
    )
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        selector = "nginx-ingress-controller-${random_string.selector.result}"
      }
    }

    template {
      metadata {
        annotations = merge(
          {
            "prometheus.io/scrape" = "true"
            "prometheus.io/port" = local.controller_port
          },
          var.annotations,
          var.deployment_template_annotations
        )
        labels = merge(
          {
            "instance" = var.deployment_name
            selector = "nginx-ingress-controller-${random_string.selector.result}"
          },
          local.labels,
          var.labels,
          var.deployment_template_labels
        )
      }

      spec {
        container {
          name = "nginx-ingress-controller"
          image = "${var.image_name}:${var.image_version}"
          args = concat(
            [
              "/nginx-ingress-controller",
              "--configmap=$(POD_NAMESPACE)/${var.nginx_configuration_name}",
              "--tcp-services-configmap=$(POD_NAMESPACE)/${var.tcp_services_name}",
              "--udp-services-configmap=$(POD_NAMESPACE)/${var.udp_services_name}",
              "--publish-service=$(POD_NAMESPACE)/${var.service_name}",
              "--annotations-prefix=${var.annotations_prefix}",
              "--election-id=${var.election_id}",
              "--ingress-class=${var.ingress_class}"
            ],
            var.additionnal_args
          )

          port {
            name = "http"
            container_port = 80
            protocol = "TCP"
          }

          port {
            name = "https"
            container_port = 443
            protocol = "TCP"
          }

          port {
            name = "metrics"
            container_port = local.controller_port
            host_port = var.controller_host_port
            protocol = "TCP"
          }

          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = local.controller_port
              scheme = "HTTP"
            }

            initial_delay_seconds = 10
            timeout_seconds = 10
            period_seconds = 10
            success_threshold = 1
            failure_threshold = 3
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = local.controller_port
              scheme = "HTTP"
            }

            timeout_seconds = 10
            period_seconds = 10
            success_threshold = 1
            failure_threshold = 3
          }

          lifecycle {
            pre_stop {
              exec {
                command = ["/wait-shutdown"]
              }
            }
          }

          security_context {
            run_as_user = 33
            allow_privilege_escalation = true
            capabilities {
              drop = ["ALL"]
              add  = ["NET_BIND_SERVICE"]
            }
          }
        }

        termination_grace_period_seconds = 300
        node_selector = var.node_selector
        service_account_name = kubernetes_service_account.this.metadata.0.name
        automount_service_account_token = true
      }
    }
  }
}


# SERVICES
resource "kubernetes_service" "this" {
  metadata {
    name = var.service_name
    namespace = var.namespace_name
    annotations = merge(
      local.annotations,
      var.annotations,
      var.service_annotations
    )
    labels = merge(
      {
        "instance" = var.service_name
      },
      local.labels,
      var.labels,
      var.service_labels
    )
  }

  spec {
    port {
      name = "http"
      port = 80
      target_port = "http"
    }

    port {
      name = "https"
      port = 443
      target_port = "https"
    }

    selector = {
      selector = "nginx-ingress-controller-${random_string.selector.result}"
    }

    type = var.service_type
    external_traffic_policy = var.service_external_traffic_policy
    load_balancer_ip = var.service_load_balancer_ip
    load_balancer_source_ranges = var.service_load_balancer_source_ranges
  }
}