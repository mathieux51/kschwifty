include ../Makefile

## all: Run targets init plan apply. Try make clean if this target fails.
all: init plan apply

## localstack: Start localstack docker image.
localstack:
	docker run --rm -it -e DEBUG=1 -p "4566:4566" -e DEFAULT_REGION="eu-central-1" localstack/localstack:latest
