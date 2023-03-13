#!/bin/bash

set -e

cd "`dirname "$0"`"

UPPER="$PWD"
PATCHSET_DIR="$UPPER/patches"
BRANCH_TO_BUILD="master"

function apply_diff_as_patch {
    local _diff_file="$1"

    # Convert the diff file into a Git patch file
    git apply --3way "${_diff_file}" || echo "Failed '${_diff_file}'" && return

    # Create a Git commit from the staged changes
    git commit -m "Apply diff file"

    # Update the diff file in-place
    git diff HEAD^ > "$_diff_file"
}

function rebase_patch {
    local _patch_file="$1"

    # Rebase the local master branch against the remote repository
    #git rebase "origin/${BRANCH_TO_BUILD}" --autostash
    git reset --hard "origin/${BRANCH_TO_BUILD}"

    # Apply the Git patch
    if ! git am --3way "${_patch_file}" ; then
        git am --abort &>/dev/null || true
        apply_diff_as_patch "${_patch_file}" || true
        return
    fi

    # If there are conflicts during the rebase, the following command
    # will automatically resolve the conflicts using the version from the patch
    git am --continue || true

    # Update the Git patch file in-place
    git format-patch HEAD^ --stdout > "$_patch_file"
}

[[ -d "gecko-dev" ]] || git clone -b "${BRANCH_TO_BUILD}" --depth 1 --single-branch "https://github.com/mozilla/gecko-dev.git" gecko-dev

LIBREWOLF_PATH="$PATCHSET_DIR/librewolf"
LIBREWOLFUI_PATH="$PATCHSET_DIR/librewolf-ui"
SEDPATCHES_PATH="$PATCHSET_DIR/sed-patches"
UNITY_KDE_PATH="$PATCHSET_DIR/unity_kde"
GENTOO_PATH="$PATCHSET_DIR/gentoo"
cd "$UPPER/gecko-dev"
git config commit.gpgsign false

for entry in "$GENTOO_PATH/"*; do rebase_patch "$entry"; done;
for entry in "$LIBREWOLF_PATH/"*; do rebase_patch "$entry"; done;
for entry in "$LIBREWOLFUI_PATH/"*; do rebase_patch "$entry"; done;
for entry in "$SEDPATCHES_PATH/"*; do rebase_patch "$entry"; done;
for entry in "$UNITY_KDE_PATH/"*; do rebase_patch "$entry"; done;
