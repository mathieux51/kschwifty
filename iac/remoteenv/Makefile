include ../Makefile

## all: Run targets init_with_backend plan apply. Try make clean if this target fails.
all: init_with_backend plan apply

## kops-create: Create a cluster with kops
kops-create:
	kops create cluster \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		--zones=$(shell terraform output availability_zones) \
		--master-zones=$(shell terraform output availability_zones) \
		--ssh-public-key=~/.ssh/id_ed25519.pub \
		--target=terraform \
		--out=.

kops-template:
	./scripts/kops-template

## kops-delete: Delete the cluster
kops-delete:
	kops delete cluster \
		--name=$(shell terraform output cluster_name) \
		--state=$(shell terraform output kops_state_store) \
		--yes
