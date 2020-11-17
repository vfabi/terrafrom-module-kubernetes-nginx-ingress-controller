# GLOBAL
variable "annotations" {
  description = "Map of annotations that will be merged with all other annotations on all kubernetes resources."
  default = {}
}

variable "labels" {
  description = "Map of labels that will be merged with all other labels on all kubernetes resource."
  default = {}
}


# NAMESPACE
variable "namespace_name" {
  description = "Name of the namespace to create and deploy the nginx-ingress-controller. *Note: This is an opinianated choice of forcing the nginx-ingress-controller to run in it's own namespace.*"
  type = string
  default = null
}


# CONFIGMAPS
variable "config_map_annotations" {
  description = "Map of annotations to apply to all config maps."
  default = {}
}

variable "config_map_labels" {
  description = "Map of labels to apply to all config maps."
  default = {}
}

variable "nginx_configuration_name" {
  description = "Name of the nginx_configuration config map to create."
  default = "nginx-ingress-controller"
}

variable "nginx_configuration_annotations" {
  description = "Map of annotations to apply to the nginx_configuration config map."
  default = {}
}

variable "nginx_configuration_labels" {
  description = "Map of labels to apply to the nginx_configuration config map."
  default = {}
}

variable "nginx_configuration_data" {
  description = "Map representing the configuration for nginx-ingress-controller."
  default = {}
}

variable "tcp_services_name" {
  description = "Name of the tcp_services config map to create."
  default = "tcp-services"
}

variable "tcp_services_annotations" {
  description = "Map of annotations to apply to the tcp_services config map."
  default = {}
}

variable "tcp_services_labels" {
  description = "Map of labels to apply to the tcp_services config map."
  default = {}
}

variable "tcp_services_data" {
  description = "Map representing the tcp services configuration for nginx-ingress-configuration."
  default = {}
}

variable "udp_services_name" {
  description = "Name of the udp_services config map to create."
  default = "udp-services"
}

variable "udp_services_annotations" {
  description = "Map of annotations to apply to the udp_services config map."
  default = {}
}

variable "udp_services_labels" {
  description = "Map of labels to apply to the udp_services config map."
  default = {}
}

variable "udp_services_data" {
  description = "Map representing the tcp services configuration for nginx-ingress-configuration."
  default = {}
}


# SERVICE ACCOUNTS
variable "service_account_name" {
  description = "Name of the service account to create for nginx-ingress-controller. *Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.*"
  default = "nginx-ingress-controller"
}

variable "service_account_annotations" {
  description = "Map of annotations to apply to the service account."
  default = {}
}

variable "service_account_labels" {
  description = "Map of labels to apply to the service account."
  default = {}
}


# ROLE
variable "role_name" {
  description = "Name of the role to create for nginx-ingress-controller. *Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.*"
  default = "nginx-ingress-controller"
}

variable "role_annotations" {
  description = "Map of annotations to apply to the role."
  default = {}
}

variable "role_labels" {
  description = "Map of labels to apply to the role."
  default = {}
}

variable "role_binding_name" {
  description = "Name of the role binding to create for nginx-ingress-controller. *Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.*"
  default = "nginx-ingress-controller"
}

variable "role_binding_annotations" {
  description = "Map of annotations to apply to the role binding."
  default = {}
}

variable "role_binding_labels" {
  description = "Map of labels to apply to the role binding."
  default = {}
}


# CLUSTER ROLE
variable "cluster_role_name" {
  description = "Name of the cluster role to create for nginx-ingress-controller. *Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.*"
  default = "nginx-ingress-controller"
}

variable "cluster_role_annotations" {
  description = "Map of annotations to apply to the cluster role."
  default = {}
}

variable "cluster_role_labels" {
  description = "Map of labels to apply to the cluster role."
  default = {}
}

variable "cluster_role_binding_name" {
  description = "Name of the cluster role binding to create for nginx-ingress-controller. *Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.*"
  default = "nginx-ingress-controller"
}

variable "cluster_role_binding_annotations" {
  description = "Map of annotations to apply to the cluster role binding."
  default = {}
}

variable "cluster_role_binding_labels" {
  description = "Map of labels to apply to the cluster role binding."
  default = {}
}


# DEPLOYMENT
variable "deployment_name" {
  description = "Name of the deployment to create for nginx-ingress-controller."
  default = "nginx-ingress-controller"
}

variable "deployment_annotations" {
  description = "Map of annotations to apply to the deployment."
  default = {}
}

variable "deployment_labels" {
  description = "Map of labels to apply to the deployment."
  default = {}
}

variable "deployment_template_annotations" {
  description = "Map of annotations to apply to the deployment template."
  default = {}
}

variable "deployment_template_labels" {
  description = "Map of labels to apply to the deployment template."
  default = {}
}

variable "replicas" {
  description = "Number of replica's to deploy."
  default = 3
}

variable "image_name" {
  description = "Name of the image to use."
  default = "quay.io/kubernetes-ingress-controller/nginx-ingress-controller"
}

variable "image_version" {
  description = "Version of the image to use."
  default = "0.26.1"
}

variable "additionnal_args" {
  description = "List of additionnal arguments to pass to the nginx-ingress-controller."
  default = []
}

variable "annotations_prefix" {
  description = "Annotations that nginx-ingress-controller will watch on ingresses."
  default = "nginx.ingress.kubernetes.io"
}

variable "election_id" {
  description = "Election id to use for Ingress status updates."
  default = "ingress-controller-leader"
}

variable "ingress_class" {
  description = "Name of the ingress class this controller satisfies. The class of an Ingress object is set using the annotation \"kubernetes.io/ingress.class\"."
  default = "nginx"
}

variable "node_selector" {
  description = "Map of key value that will be used to select appropriate nodes"
  default = {
    "kubernetes.io/os" = "linux"
  }
}

variable "controller_host_port" {
  description = "Port number on which the controller will be available on the host (0-65536)"
  default = null
  type = number
}


# SERVICE
variable "service_name" {
  description = "Name of the service to create for nginx-ingress-controller."
  default = "nginx-ingress-controller"
}

variable "service_annotations" {
  description = "Map of annotations to apply to the service."
  default = {}
}

variable "service_labels" {
  description = "Map of labels to apply to the service."
  default = {}
}

variable "service_load_balancer_ip" {
  description = "IP address to be used for the service."
  type = string
  default = null
}

variable "service_load_balancer_source_ranges" {
  description = "List of source ranges that will be allowed access to the load balancer."
  type = list(string)
  default = null
}

variable "service_type" {
  description = "Type of service to create for the nginx-ingress-controller."
  default = "LoadBalancer"
}

variable "service_external_traffic_policy" {
  description = "The external traffic policy for the service."
  default = "Local"
}
