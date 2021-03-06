package kubernetes.admission

deny[msg] {
    input.request.kind.kind = "Deployment"
    input.request.operation = "CREATE"
    servicetype = input.request.kind.kind
    name = input.request.object.metadata.name
    containers := input.request.object.spec.template.spec.containers[_]
    not containers.readinessProbe
    msg = sprintf("Rejecting \"%v/%v\" for not specifying a readinessProbe", [servicetype, name])
}