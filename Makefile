SHELL := /bin/bash

publish:
	@ TAG=$$(git tag --points-at HEAD); if [ "$$TAG" == "" ]; then echo Not tagged; exit 1; fi; cue mod publish "$$TAG"