include ../Makefile

## all: Run targets init_with_backend plan apply. Try make clean if this target fails.
all: init_with_backend plan apply

## kops-template: Render template kops/template.yaml.
kops-template:
	@./scripts/kops-template.sh

## kops-replace: Update kops with rendered version of the template.
kops-replace:
	@kops replace \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		-f "$(shell terraform output cluster_name)-cluster.yaml" \
		--force

## kops-update: Update cluster and generate terraform code.
kops-update:
	@kops update cluster \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		--out=. \
		--target=terraform

## update-cluster: Update the cluster by running targets plan_and_apply kops-template kops-replace kops-update
update-cluster: kops-template kops-replace kops-update

## kops-delete: Delete the cluster
kops-delete:
	@kops delete cluster \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		--yes

## kops-add-sshpublickey: Add ssh pulic key id_rsa.pub to kops.
kops-add-sshpublickey:
	@kops create secret \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		sshpublickey admin \
		-i ~/.ssh/id_rsa.pub
