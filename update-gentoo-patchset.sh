#!/bin/bash

set -e

cd "$(dirname "$0")"

UPPER="$PWD"

FIREFOX_PATCHSET="firefox-132-patches-03.tar.xz"
GENTOO_PATH="$UPPER/patches/gentoo"

curl -o "$UPPER/$FIREFOX_PATCHSET" https://dev.gentoo.org/~{juippis,polynomial-c,whissi,slashbeast}/mozilla/patchsets/"${FIREFOX_PATCHSET}"
tar -xf "$UPPER/$FIREFOX_PATCHSET"

rm -f "$GENTOO_PATH"/*
mv firefox-patches/* "$GENTOO_PATH"/
rm -rf firefox-patches

rm -f "$UPPER/$FIREFOX_PATCHSET"
