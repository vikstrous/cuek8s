SHELL := /bin/bash

generate:
	cue get go k8s.io/api/core/v1

publish:
	@ TAG=$$(git tag --points-at HEAD); if [ "$$TAG" == "" ]; then echo Not tagged; exit 1; fi; cue mod publish "$$TAG"