#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

export CLUSTER_NAME=$(terraform output cluster_name)
export KOPS_STATE_STORE=$(terraform output kops_state_store)
export AWS_AVAILABILITY_ZONES=$(terraform output -json availability_zones | jq -r '.value|join(",")')

cat << EOF > cluster.yaml
name: $CLUSTER_NAME
state: $KOPS_STATE_STORE
master-zones: $AWS_AVAILABILITY_ZONES
zones: $AWS_AVAILABILITY_ZONES
target: terraform
out=: .
EOF
