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

# Based on https://github.com/jetstack/cert-manager/releases/tag/v0.11.0

_deny = msg {
  kinds := ["Certificate", "Issuer", "ClusterIssuer", "CertificateRequest"]
  input.apiVersion == "certmanager.k8s.io/v1alpha1"
  input.kind == kinds[_]
  msg := sprintf("%s/%s: API certmanager.k8s.io/v1alpha1 for %s is obsolete, use cert-manager.io/v1alpha2 instead.", [input.kind, input.metadata.name, input.kind])
}

_deny = msg {
  kinds := ["Order", "Challenge"]
  input.apiVersion == "certmanager.k8s.io/v1alpha1"
  input.kind == kinds[_]
  msg := sprintf("%s/%s: API certmanager.k8s.io/v1alpha1 for %s is obsolete, use acme.cert-manager.io/v1alpha2 instead.", [input.kind, input.metadata.name, input.kind])
}