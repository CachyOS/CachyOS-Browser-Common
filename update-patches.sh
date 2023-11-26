#!/bin/bash

set -e

cd "`dirname "$0"`"

UPPER="$PWD"

function move {
    mv -v $1 "$UPPER/patches/$2" || true
}

rebrand() {
    find ./* -type f -exec sed -i "s/$1/$2/g" {} +
}

# cleanup librewolf patches
rm -rf patches/{sed-patches,librewolf-ui,unity_kde,librewolf,pref-pane}/*

[[ -d "librewolf" ]] || git clone --depth 1 -q "https://gitlab.com/librewolf-community/browser/source.git" librewolf
cd $UPPER/librewolf/patches

for entry in "sed-patches/"*; do move "$entry" sed-patches; done;
for entry in "ui-patches/"*; do move "$entry" librewolf-ui; done;
for entry in "unity_kde/"*; do move "$entry" unity_kde; done;

for entry in "./"*; do
    [[ -d "$entry" ]] || move "$entry" librewolf
done

for entry in "./pref-pane/"*; do
    [[ -d "$entry" ]] || move "$entry" pref-pane
done

cd $UPPER
rm -rf librewolf

cd $UPPER/patches

# remove and rename files at pref-pane
rm -f pref-pane/README.md
$UPPER/rename-files.py pref-pane librewolf cachy-browser
cp $UPPER/category-cachy-browser.svg pref-pane/category-cachy-browser.svg

# rename file names in librewolf patchset folders
$UPPER/rename-files.py sed-patches librewolf cachy-browser
$UPPER/rename-files.py librewolf-ui librewolf cachy-browser
$UPPER/rename-files.py unity_kde librewolf cachy-browser
$UPPER/rename-files.py librewolf librewolf cachy-browser

curl -o librewolf-patchset.txt 'https://gitlab.com/librewolf-community/browser/source/-/raw/main/assets/patches.txt'

sed -i 's/lib\/librewolf/lib\/cachy-browser/g' librewolf/mozilla_dirs.patch
sed -i 's/lib64\/librewolf/lib64\/cachy-browser/g' librewolf/mozilla_dirs.patch
sed -i 's/librewolf/cachy/g' librewolf/mozilla_dirs.patch

rebrand "\/io\/gitlab\/" "\/org\/cachyos\/"
rebrand "io.gitlab." "org.cachyos."
rebrand LibreWolf Cachy
rebrand Librewolf Cachy
rebrand librewolf cachy-browser
rebrand "cachy-browser\.net" "librewolf.net"
rebrand "#why-is-cachy-browser-forcing-light-theme" "#why-is-librewolf-forcing-light-theme"

rebrand cachy-browser.cfg cachyos.cfg

rebrand "cachy-browser\/cachy-browser-pref-pane.patch" "librewolf\/librewolf-pref-pane.patch"

# we do that after rebrand step is done
$UPPER/manage-librewolf-patchlist.py --file="librewolf-patchset.txt" --exclude="windows-theming-bug,rust-gentoo-musl,flatpak-autoconf"
