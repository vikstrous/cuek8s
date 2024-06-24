#!/usr/bin/env bash

# This script is a hack to copy the gen directory into the body of the module because modules can't use a gen directory right now. See https://github.com/cue-lang/cue/issues/3233

rm -rf gen
cp -r ./cue.mod/gen ./gen
find ./gen -type f -exec sed -i -E '/import \(/,/^\)/{s/"([^"]*)"/"github.com\/vikstrous\/cuek8s\/gen\/\1"/g}' {} +