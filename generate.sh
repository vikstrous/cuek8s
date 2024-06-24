#!/usr/bin/env bash
set -e

# This script is a hack to copy the gen directory into the body of the module because modules can't use a gen directory right now. See https://github.com/cue-lang/cue/issues/3233

cue get go k8s.io/api/core/v1
rm -rf gen
cp -r ./cue.mod/gen ./gen
rm -rf cue.mod/gen
find ./gen -type f -exec sed -i -E '/import \(/,/^\)/{s/"([^"]*)"/"github.com\/vikstrous\/cuek8s\/gen\/\1"/g}' {} +