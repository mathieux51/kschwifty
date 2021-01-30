.DEFAULT_GOAL := help
.PHONY: stage init init_with_backend check format plan apply plan_and_apply clean destroy deploy_image_lambda all

TF_INIT=terraform init

## stage: echo the stage variable TF_VAR_stage. Throw error if not set. It's required to know where to deploy.
stage:
	@if test -z "$$TF_VAR_stage"; then echo "STAGE should be set (development or production)"; exit 1; else echo "TF_VAR_stage: \"${TF_VAR_stage}\""; fi;

## init: Initialize terraform.
init: stage
	terraform --version
	$(TF_INIT)

## init_with_backend: Override init target because we need -backend-config flag to inject backend's bucket name.
init_with_backend: stage
	$(TF_INIT) -backend-config=backend-configs/${TF_VAR_stage}.hcl

## check: Validate the configuration files in a directory.
check: stage
	terraform fmt -recursive -check -diff
	terraform validate

## format: Recursively format .tf files.
format: stage
	terraform fmt -recursive

## plan: Plan terraform changes and output planfile.
plan: stage
	terraform plan -out "planfile"

## apply: Apply the terraform planfile.
apply: stage
	terraform apply -auto-approve -input=false "planfile"

## plan_and_apply: Plan and then apply.
plan_and_apply: plan apply

## clean: Remove terraform files.
clean:
	rm -rf terraform.tfstate plan .terraform crash.log terraform.tfstate.backup planfile .terraform.lock.hcl

## destroy: Destroy all terraform ressources.
destroy:
	terraform destroy -auto-approve

## :
## help: Print out available make targets.
help: Makefile
	@echo
	@echo " Choose a target run:"
	@echo
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -n 's/^##//p' | column -t -s ':' |  sed -e 's/^/ /'
	@echo
