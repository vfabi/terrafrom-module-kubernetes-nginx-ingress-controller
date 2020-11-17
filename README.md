# Kubernetes nginx-ingress-controller Terraform module
Terraform module to deploy nginx-ingress-controller and create all need resources in Kubernetes cluster using Hashicorp's kubernetes provider.  
These types of Kubernetes provider resources used in module:  
- kubernetes_deployment
- kubernetes_role
- kubernetes_role_binding
- kubernetes_cluster_role
- kubernetes_cluster_role_binding
- kubernetes_service
- kubernetes_config_map
- kubernetes_service_account


## Features
Module creates all Kubernetes resources, configuration need for nginx-ingress-controller deploy.


## Requirements
- Terraform >= 0.13.5
- Kubernetes >= 1.10.0


## Providers
- hashicorp/kubernetes >= 1.13.3 (`https://registry.terraform.io/providers/hashicorp/kubernetes/`)
- random >= 3.0.0


## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additionnal\_args | List of additionnal arguments to pass to the nginx-ingress-controller. | `list` | `[]` | no |
| annotations | Map of annotations that will be merged with all other annotations on all kubernetes resources. | `map` | `{}` | no |
| annotations\_prefix | Annotations that nginx-ingress-controller will watch on ingresses. | `string` | `"nginx.ingress.kubernetes.io"` | no |
| cluster\_role\_annotations | Map of annotations to apply to the cluster role. | `map` | `{}` | no |
| cluster\_role\_binding\_annotations | Map of annotations to apply to the cluster role binding. | `map` | `{}` | no |
| cluster\_role\_binding\_labels | Map of labels to apply to the cluster role binding. | `map` | `{}` | no |
| cluster\_role\_binding\_name | Name of the cluster role binding to create for nginx-ingress-controller. \*Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.\* | `string` | `"nginx-ingress-controller"` | no |
| cluster\_role\_labels | Map of labels to apply to the cluster role. | `map` | `{}` | no |
| cluster\_role\_name | Name of the cluster role to create for nginx-ingress-controller. \*Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.\* | `string` | `"nginx-ingress-controller"` | no |
| config\_map\_annotations | Map of annotations to apply to all config maps. | `map` | `{}` | no |
| config\_map\_labels | Map of labels to apply to all config maps. | `map` | `{}` | no |
| controller\_host\_port | Port number on which the controller will be available on the host (0-65536) | `number` | `null` | no |
| deployment\_annotations | Map of annotations to apply to the deployment. | `map` | `{}` | no |
| deployment\_labels | Map of labels to apply to the deployment. | `map` | `{}` | no |
| deployment\_name | Name of the deployment to create for nginx-ingress-controller. | `string` | `"ingress-nginx"` | no |
| deployment\_template\_annotations | Map of annotations to apply to the deployment template. | `map` | `{}` | no |
| deployment\_template\_labels | Map of labels to apply to the deployment template. | `map` | `{}` | no |
| election\_id | Election id to use for Ingress status updates. | `string` | `"ingress-controller-leader"` | no |
| image\_name | Name of the image to use. | `string` | `"quay.io/kubernetes-ingress-controller/nginx-ingress-controller"` | no |
| image\_version | Version of the image to use. | `string` | `"0.26.1"` | no |
| ingress\_class | Name of the ingress class this controller satisfies. The class of an Ingress object is set using the annotation "kubernetes.io/ingress.class". | `string` | `"nginx"` | no |
| labels | Map of labels that will be merged with all other labels on all kubernetes resource. | `map` | `{}` | no |
| namespace\_name | Name of the pre-created namespace to deploy the nginx-ingress-controller. \*Note: This is an opinianated choice of forcing the nginx-ingress-controller to run in it's own namespace.\* | `string` | | yes |
| nginx\_configuration\_annotations | Map of annotations to apply to the nginx\_configuration config map. | `map` | `{}` | no |
| nginx\_configuration\_data | Map representing the configuration for nginx-ingress-controller. | `map` | `{}` | no |
| nginx\_configuration\_labels | Map of labels to apply to the nginx\_configuration config map. | `map` | `{}` | no |
| nginx\_configuration\_name | Name of the nginx\_configuration config map to create. | `string` | `"nginx-configuration"` | no |
| node\_selector | Map of key value that will be used to select appropriate nodes | `map` | <pre>{<br>  "kubernetes.io/os": "linux"<br>}</pre> | no |
| replicas | Number of replica's to deploy. | `number` | `3` | no |
| role\_annotations | Map of annotations to apply to the role. | `map` | `{}` | no |
| role\_binding\_annotations | Map of annotations to apply to the role binding. | `map` | `{}` | no |
| role\_binding\_labels | Map of labels to apply to the role binding. | `map` | `{}` | no |
| role\_binding\_name | Name of the role binding to create for nginx-ingress-controller. \*Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.\* | `string` | `"ingress-nginx"` | no |
| role\_labels | Map of labels to apply to the role. | `map` | `{}` | no |
| role\_name | Name of the role to create for nginx-ingress-controller. \*Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.\* | `string` | `"ingress-nginx"` | no |
| service\_account\_annotations | Map of annotations to apply to the service account. | `map` | `{}` | no |
| service\_account\_labels | Map of labels to apply to the service account. | `map` | `{}` | no |
| service\_account\_name | Name of the service account to create for nginx-ingress-controller. \*Note: This is an opinianated choice of forcing the nginx-ingress-controller to use RBAC.\* | `string` | `"ingress-nginx"` | no |
| service\_annotations | Map of annotations to apply to the service. | `map` | `{}` | no |
| service\_external\_traffic\_policy | The external traffic policy for the service. | `string` | `"Local"` | no |
| service\_labels | Map of labels to apply to the service. | `map` | `{}` | no |
| service\_load\_balancer\_ip | IP address to be used for the service. | `string` | `null` | no |
| service\_load\_balancer\_source\_ranges | List of source ranges that will be allowed access to the load balancer. | `list(string)` | `null` | no |
| service\_name | Name of the service to create for nginx-ingress-controller. | `string` | `"ingress-nginx"` | no |
| service\_type | Type of service to create for the nginx-ingress-controller. | `string` | `"LoadBalancer"` | no |
| tcp\_services\_annotations | Map of annotations to apply to the tcp\_services config map. | `map` | `{}` | no |
| tcp\_services\_data | Map representing the tcp services configuration for nginx-ingress-configuration. | `map` | `{}` | no |
| tcp\_services\_labels | Map of labels to apply to the tcp\_services config map. | `map` | `{}` | no |
| tcp\_services\_name | Name of the tcp\_services config map to create. | `string` | `"tcp-services"` | no |
| udp\_services\_annotations | Map of annotations to apply to the udp\_services config map. | `map` | `{}` | no |
| udp\_services\_data | Map representing the tcp services configuration for nginx-ingress-configuration. | `map` | `{}` | no |
| udp\_services\_labels | Map of labels to apply to the udp\_services config map. | `map` | `{}` | no |
| udp\_services\_name | Name of the udp\_services config map to create. | `string` | `"udp-services"` | no |


## Outputs
| Name | Description |
|------|-------------|
| annotation\_prefix | Annotation prefix to be used by this ingress controller. |
| cluster\_role | n/a |
| cluster\_role\_binding | n/a |
| config\_map\_nginx\_configuration | n/a |
| config\_map\_tcp\_services | n/a |
| config\_map\_udp\_services | n/a |
| deployment | n/a |
| ingress\_class | Ingress-class to be used by this ingress controller. |
| load\_balancer\_ingress | List of ingress points for the load-balancer. |
| namespace | n/a |
| role | n/a |
| role\_binding | n/a |
| service | n/a |
| service\_account | n/a |


## Usage

```terraform

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}


provider "kubernetes" {
  load_config_file = "false"
  host = "https://<KUBERNETES_CLUSTER_IP>:<KUBERNETES_CLUSTER_PORT>"
  client_certificate = file("/<PATH_TO_KUBERNETES_CLIENT_CERTIFICATE_FILE>/client.crt")
  client_key = file("/<PATH_TO_KUBERNETES_CLIENT_KEY_FILE>/client.key")
  cluster_ca_certificate = file("/<PATH_TO_KUBERNETES_CA_CERTIFICATE_FILE>/ca.crt")
}


module "controller-nginx-ingress" {
    source = "github.com/vfabi/terrafrom-module-kubernetes-nginx-ingress-controller?ref=1.0"

    # Provider explicit definition (optional).
    #providers = {
    #    kubernetes = kubernetes
    #}

    namespace_name = "default"  # required, need to be pre-created
    replicas = "2"  # optional, default="3"
    service_type = "NodePort"  # optional, default="LoadBalancer"
}
```


## Contributing
Please refer to each project's style and contribution guidelines for submitting patches and additions. In general, we follow the "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

NOTE: Be sure to merge the latest from "upstream" before making a pull request!


## License
Apache 2.0
