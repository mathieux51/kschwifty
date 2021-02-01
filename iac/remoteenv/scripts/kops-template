#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

terraform_output=$(terraform output -json)
cluster_name="$(echo ${terraform_output} | jq -r .cluster_name.value)"

kops toolbox template \
  --name ${cluster_name} \
  --values <( echo ${terraform_output}) \
  --template kops/template.yaml \
  --format-yaml > "$cluster_name-cluster.yaml"
