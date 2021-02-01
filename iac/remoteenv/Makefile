include ../Makefile

## all: Run targets init_with_backend plan apply. Try make clean if this target fails.
all: init_with_backend plan apply

kops-template:
	@./scripts/kops-template

kops-replace:
	kops replace \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		-f "$(shell terraform output cluster_name)-cluster.yaml" \
		--force

kops-update:
	kops update cluster \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		--out=. \
		--target=terraform

kops-add-sshpublickey:
	kops create secret \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		sshpublickey admin \
		-i ~/.ssh/id_ed25519.pub

## kops-delete: Delete the cluster
kops-delete:
	kops delete cluster \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		--yes
