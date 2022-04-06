NAMESPACE ?= spot
AWS_ACCESS_KEY_ID ?= default_id
AWS_SECRET_ACCESS_KEY ?= default_key
AWS_DEFAULT_REGION ?= us-east-1
KUBECONFIG ?= kubeconfig_path
AWS_ACCESS_KEY_ID_ENCODED := $(shell echo -n $${AWS_ACCESS_KEY_ID} | base64)
AWS_SECRET_ACCESS_KEY_ENCODED := $(shell echo -n $${AWS_SECRET_ACCESS_KEY} | base64)
CONTEXT = default
AWS_CLI_VERSION = 2.5.2
SPOT_ASG ?= spot-worker-3f3920bc-7ea3-4d78-b7f1-9cd83555eee6
DESIRED_CAPACITY_UP = 2
DESIRED_CAPACITY_DOWN = 1

export NAMESPACE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION AWS_ACCESS_KEY_ID_ENCODED \
	AWS_SECRET_ACCESS_KEY_ENCODED AWS_CLI_VERSION SPOT_ASG DESIRED_CAPACITY_UP DESIRED_CAPACITY_DOWN

clean:
	kubectl delete --context $(CONTEXT) --kubeconfig $(KUBECONFIG) ns $(NAMESPACE)

apply:
	envsubst < 01_namespace.yaml | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -
	envsubst < 02_secrets.yaml | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -

#	cd kustomize && kustomize build | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -

#envsubst < 03_job.yaml | kubectl apply --context $(CONTEXT) --kubeconfig $(KUBECONFIG) -f -
