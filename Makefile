.PHONY: all
all: source kustomization

.PHONY: source
source:
	flux create source git team-2 \
		--namespace=team-2 \
		--url=https://github.com/rparmer/flux-multi-tenancy-team-2 \
		--branch=main \
		--interval=1m

.PHONY: kustomization
kustomization:
	flux create kustomization team-2 \
		--namespace=team-2 \
		--source=team-2 \
		--service-account=team-2 \
		--path=kustomize \
		--prune=true \
		--interval=5m

.PHONY: cleanup
cleanup:
	flux delete kustomization team-2 --namespace team-2 --silent
	flux delete source git team-2 --namespace team-2 --silent
