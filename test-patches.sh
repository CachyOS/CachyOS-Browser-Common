#!/bin/bash

set -e

cd "`dirname "$0"`"

UPPER="$PWD"
PATCHESDIR="$PWD/patches"
TEMPDIRTEST="$PWD/tempsrcdirtest"
SETTINGSDIRTEST="$PWD/settingsdirtest"

pkgver=128.0.3
FIREFOX_TAR="firefox-$pkgver.source.tar.xz"
FIREFOX_URL="https://archive.mozilla.org/pub/firefox/releases/$pkgver/source/$FIREFOX_TAR"
FIREFOX_DIR="$TEMPDIRTEST/firefox-$pkgver"

function unpack_xz() {
    local _xz_archive="$1"
    local _dest="$2"

    tar xf "$_xz_archive" -C "$_dest"
}

rm -rf "$TEMPDIRTEST"
mkdir -p "$TEMPDIRTEST"

[[ -d "$SETTINGSDIRTEST" ]] || git clone --depth 1 -q "https://github.com/cachyos/cachyos-browser-common.git" "$SETTINGSDIRTEST"

curl -o "$UPPER/$FIREFOX_TAR" "${FIREFOX_URL}"
unpack_xz "$UPPER/$FIREFOX_TAR" "$TEMPDIRTEST"

# Apply patches
echo ">>> =+=+=+=+= Applying patches =+=+=+=+="
${UPPER}/apply-patches.py "$FIREFOX_DIR" "$UPPER" "$SETTINGSDIRTEST"

# Applying additional patches
echo ">>> =+=+=+=+= Applying additional patches =+=+=+=+="

echo ">>> fix an URL in 'about' dialog"
patch -Np1 -i "${PATCHES_DIR}/about-dialog.patch"

# we keep that until we actually create locale for Firefox to replace strings with "Cachy"
echo ">>> add warning that sanitizing exceptions are bypassed by the options in History > Clear History when Cachy closes > Settings"
patch -Np1 -i "${PATCHES_DIR}/sanitizing-description.patch"

#echo ">>> KDE menu and unity menubar"
#patch -Np1 -i "${PATCHES_DIR}/unity_kde/mozilla-kde.patch"
#patch -Np1 -i "${PATCHES_DIR}/unity_kde/firefox-kde.patch"
#patch -Np1 -i "${PATCHES_DIR}/unity_kde/unity-menubar.patch"

echo ">>> mozilla-nongnome-proxies"
patch -Np1 -i "${PATCHES_DIR}/kde/mozilla-nongnome-proxies.patch"
