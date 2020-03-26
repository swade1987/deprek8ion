package main

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

# Based on https://github.com/kubernetes/kubernetes/issues/47198
# Warn about the deprecated serviceAccount field in podSpec.

_warn = msg {
  resources := ["Pod"]
  input.kind == resources[_]
  input.spec.serviceAccount
  msg := sprintf("%s/%s: The serviceAccount field in the podSpec will be deprecated soon, use serviceAccountName instead.", [input.kind, input.metadata.name])
}

_warn = msg {
  resources := ["CronJob"]
  input.kind == resources[_]
  input.spec.jobTemplate.spec.template.spec.serviceAccount
  msg := sprintf("%s/%s: The serviceAccount field in the podSpec will be deprecated soon, use serviceAccountName instead.", [input.kind, input.metadata.name])
}

_warn = msg {
  resources := ["Deployment", "DaemonSet", "Job", "ReplicaSet", "ReplicationController", "StatefulSet"]
  input.kind == resources[_]
  input.spec.template.spec.serviceAccount
  msg := sprintf("%s/%s: The serviceAccount field in the podSpec will be deprecated soon, use serviceAccountName instead.", [input.kind, input.metadata.name])
}

