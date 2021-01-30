include ../Makefile

## all: Run targets init_with_backend plan apply. Try make clean if this target fails.
all: init_with_backend plan apply

KOPS=kops -f cluster.yaml

generate-cluster-config:
	@sh generate-cluster-yaml.sh

## kops-create: Create a cluster with kops
kops-create: generate-cluster-config
	$(KOPS) create cluster
