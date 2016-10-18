#!/bin/bash

function fail {
    echo "$@" >&2
    exit 1
}

ARMEL_TGZ=qemu-raspberry-pi-armel.tar.gz
ARMHF_TGZ=qemu-raspberry-pi-armhf.tar.gz

USER=hverr
REPO=qemu-raspberry-pi-arm-ghc

[ -z "$GITHUB_TOKEN" ] && fail "error: GITHUB_TOKEN not set"
! which github-release >/dev/null && fail "error: github-release not in PATH"

[ $# -ne 1 ] && fail "error: usage: $0 tag"
TAG="$1"

set -ex

github-release info -u $USER -r $REPO -t "$TAG" > /dev/null || fail "error: release with tag $TAG does not exist"

[ ! -f "$ARMEL_TGZ" ] && tar -cvzf $ARMEL_TGZ armel
[ ! -f "$ARMHF_TGZ" ] && tar -cvzf $ARMHF_TGZ armhf

github-release -v upload -u $USER -r $REPO -t $TAG \
    --name "$ARMEL_TGZ" \
    --file "$ARMEL_TGZ"

github-release -v upload -u $USER -r $REPO -t $TAG \
    --name "$ARMHF_TGZ" \
    --file "$ARMHF_TGZ"
