#!/bin/bash

if ! command -v yq &> /dev/null; then
    printf '<missing yq>'
    exit 0
fi

if ! command -v jq &> /dev/null; then
    printf '<missing jq>'
    exit 0
fi

VALUES="$(yq eval '. as $config
    | $config["current-context"] as $context
    | [
	$context,
	($config.contexts[] | select(.name == $context) | .context.namespace)
    ] []' ~/.kube/config)"
KUBE_CONTEXT="$(printf '%s' "$VALUES" | head -n 1)"
KUBE_NAMESPACE="$(printf '%s' "$VALUES" | tail -n 1)"

if [ "$KUBE_NAMESPACE" == "default" || -z "$KUBE_NAMESPACE" ]; then
    printf '%s' "$KUBE_CONTEXT"
else
    printf '%s/%s' "$KUBE_CONTEXT" "$KUBE_NAMESPACE"
fi

