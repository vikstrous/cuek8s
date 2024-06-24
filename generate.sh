#!/usr/bin/env bash
set -e

# This script is a hack to copy the gen directory into the body of the module because modules can't use a gen directory right now. See https://github.com/cue-lang/cue/issues/3233

cue get go "github.com/GoogleCloudPlatform/gke-managed-certs/pkg/apis/networking.gke.io/v1"
cue get go "github.com/kubernetes-csi/external-snapshotter/client/v4/apis/volumesnapshot/v1"
cue get go "istio.io/api/networking/v1"
cue get go "istio.io/api/security/v1"
cue get go "k8s.io/api/apps/v1"
cue get go "k8s.io/api/batch/v1"
cue get go "k8s.io/api/core/v1"
cue get go "k8s.io/api/networking/v1"
cue get go "k8s.io/api/policy/v1"
cue get go "k8s.io/api/storage/v1"
cue get go "k8s.io/ingress-gce/pkg/apis/backendconfig/v1"
cue get go "k8s.io/ingress-gce/pkg/apis/frontendconfig/v1beta1"

rm -rf gen
cp -r ./cue.mod/gen ./gen
# Deleting the original gen directory is important to ensure that we don't accidentally leave any uses of it behind that make it look like things worked when they didn't
rm -rf cue.mod/gen
find ./gen -type f -exec sed -i -E '/import \(/,/^\)/{s/"([^"]*)"/"github.com\/vikstrous\/cuek8s\/gen\/\1"/g}' {} +
find ./gen -type f -exec sed -i -E 's/import ([^ ]* )?"([^"]*)"/import \1"github.com\/vikstrous\/cuek8s\/gen\/\2"/g' {} +