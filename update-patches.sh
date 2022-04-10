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

[[ -d "librewolf" ]] || git clone --depth 1 -q "https://gitlab.com/librewolf-community/browser/source.git" librewolf
cd $UPPER/librewolf/patches

for entry in "sed-patches/"*; do move "$entry" sed-patches; done;
for entry in "ui-patches/"*; do move "$entry" librewolf-ui; done;

for entry in "./"*; do
    [[ -d "$entry" ]] || move "$entry" librewolf
done

cd $UPPER
rm -rf librewolf

cd $UPPER/patches

sed -i 's/lib\/librewolf/lib\/cachy-browser/g' librewolf/mozilla_dirs.patch
sed -i 's/lib64\/librewolf/lib64\/cachy-browser/g' librewolf/mozilla_dirs.patch
sed -i 's/librewolf/cachy/g' librewolf/mozilla_dirs.patch

rebrand "\/io\/gitlab\/" "\/org\/cachyos\/"
rebrand "io.gitlab." "org.cachyos."
rebrand LibreWolf Cachy
rebrand Librewolf Cachy
rebrand librewolf cachy-browser

rebrand cachy-browser.cfg cachyos.cfg
