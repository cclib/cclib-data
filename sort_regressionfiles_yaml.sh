#!/bin/bash

set -euo pipefail

# sort_regressionfiles_yaml.sh: Check and see if the entries in
# regressionfiles.yaml are sorted by filename, producing a diff file that
# should make them sorted.  Then, attempt to apply the diff as a patch that
# would make regressionfiles.yaml sorted, which may fail depending on any
# comments present in the original file.
#
# You should probably call this shell script and not the Python code.

if ! python sort_regressionfiles_yaml.py > regressionfiles.diff; then
    echo "difference found:"
    cat regressionfiles.diff
    if ! patch -p1 -i regressionfiles.diff regressionfiles.yaml; then
        echo "patch didn't apply cleanly"
    else
        echo "patch applied cleanly"
    fi
    exit 1
fi
