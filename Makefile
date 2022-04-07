NAMESPACE ?= spot
AWS_ACCESS_KEY_ID ?= default_id
AWS_SECRET_ACCESS_KEY ?= default_key
AWS_DEFAULT_REGION ?= us-east-1
KUBECONFIG ?= kubeconfig_path
AWS_ACCESS_KEY_ID_ENCODED := $(shell echo -n $${AWS_ACCESS_KEY_ID} | base64)
AWS_SECRET_ACCESS_KEY_ENCODED := $(shell echo -n $${AWS_SECRET_ACCESS_KEY} | base64)
CONTEXT = default
AWS_CLI_VERSION = 2.5.2
SPOT_ASG ?= spot-worker-89c1d062-1629-48ab-bfb3-b878ced8832f
SCALE_SIZE = nil
SCALE_SIZE_UP = 2
SCALE_SIZE_DOWN = 0

export NAMESPACE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION AWS_ACCESS_KEY_ID_ENCODED \
	AWS_SECRET_ACCESS_KEY_ENCODED AWS_CLI_VERSION SPOT_ASG SCALE_SIZE

clean:
	kubectl delete --context $(CONTEXT) --kubeconfig $(KUBECONFIG) ns $(NAMESPACE)

install:
	envsubst < 01_namespace.yaml | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -
	envsubst < 02_secrets.yaml | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -

pre:
	kubectl delete job aws-cli-spot-job -n $(NAMESPACE) --context $(CONTEXT) --kubeconfig $(KUBECONFIG) 2>/dev/null || true

up: pre
	$(eval SCALE_SIZE=$(SCALE_SIZE_UP))
	envsubst < scale.yaml | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -

down: pre
	$(eval SCALE_SIZE=$(SCALE_SIZE_DOWN))
	envsubst < scale.yaml | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -
