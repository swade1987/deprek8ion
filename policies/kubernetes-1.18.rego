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

# Based on https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md

# Within Ingress resources spec.ingressClassName replaces the deprecated kubernetes.io/ingress.class annotation.
_deny = msg {
  resources := ["Ingress"]
  input.kind == resources[_]
  input.metadata.annotations["kubernetes.io/ingress.class"]
  msg := sprintf("%s/%s: Ingress annotation kubernetes.io/ingress.class has been deprecated in 1.18, use spec.IngressClassName instead.", [input.kind, input.metadata.name])
}