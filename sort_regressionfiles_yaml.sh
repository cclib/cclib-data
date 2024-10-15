#!/bin/bash

set -euo pipefail

if ! command -v jq >&/dev/null; then
    echo "'jq' not installed"
    exit 1
fi
if ! command -v yq >&/dev/null; then
    echo "'yq' not installed"
    exit 1
fi

yq -y '.' regressionfiles.yaml > regressionfiles_nocomments.yaml
yq -y -s '.[0].regressions|=sort_by(.loc_entry)|.[0]' regressionfiles.yaml > regressionfiles_sorted.yaml
if ! git diff --no-index regressionfiles_nocomments.yaml regressionfiles_sorted.yaml > regressionfiles.diff; then
    cat regressionfiles.diff
    exit 1
fi
