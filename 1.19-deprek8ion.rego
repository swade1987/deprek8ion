package main

deny[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _deny with input as obj
}

deny[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _deny
}

warn[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _warn with input as obj
}

warn[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _warn
}

# Based on https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md

# The admissionregistration.k8s.io/v1beta1 versions of MutatingWebhookConfiguration and ValidatingWebhookConfiguration are deprecated in 1.19. Migrate to use admissionregistration.k8s.io/v1 instead
_warn = msg {
  kinds := ["MutatingWebhookConfiguration", "ValidatingWebhookConfiguration"]
  input.apiVersion == "admissionregistration.k8s.io/v1beta1"
  input.kind == kinds[_]
  msg := sprintf("%s/%s: API admissionregistration.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use admissionregistration.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The apiextensions.k8s.io/v1beta1 version of CustomResourceDefinition is deprecated in 1.19. Migrate to use apiextensions.k8s.io/v1 instead
_warn = msg {
  input.apiVersion == "apiextensions.k8s.io/v1beta1"
  input.kind == "CustomResourceDefinition"
 msg := sprintf("%s/%s: API apiextensions.k8s.io/v1beta1 for CustomResourceDefinition is deprecated in 1.19, use apiextensions.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}