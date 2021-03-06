#!/usr/bin/env bash

#
# Vagrant Windows box factory
#
# @author Luke Carrier <luke@carrier.im>
# @copyright 2015 Luke Carrier
# @license GPL v3
#

set -euo pipefail

ROOT_DIR="$(dirname $(readlink -fn $0))"
export PACKER_BUILD_DIR="$(mktemp -d -p "${ROOT_DIR}/builds")"
export PACKER_CACHE_DIR="${ROOT_DIR}/cache"

ARGS=( $@ )
for i in ${!ARGS[@]}; do
    if [ -f "${ARGS[$i]}" ]; then
        ARGS[$i]="$(realpath "${ARGS[$i]}")"
    fi
done

pushd "$PACKER_BUILD_DIR" >/dev/null
packer ${ARGS[@]} || true
popd >/dev/null
