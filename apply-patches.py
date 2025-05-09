#!/usr/bin/python

#
# The script that patches the firefox source into the librewolf source.
# fork of librewolf's script librewolf-patches.py
#

import sys
import os
import optparse
import time
from os.path import isfile, join

#
# general functions, skip these, they are not that interesting
#

start_time = time.time()
parser = optparse.OptionParser()
parser.add_option('-n', '--no-execute', dest='no_execute', default=False, action="store_true")
options, args = parser.parse_args()

def script_exit(statuscode):
    if (time.time() - start_time) > 60:
        # print elapsed time
        elapsed = time.strftime("%H:%M:%S", time.gmtime(time.time() - start_time))
        print("\n\aElapsed time: {elapsed}")
        sys.stdout.flush()

    sys.exit(statuscode)

def exec(cmd, exit_on_fail = True, do_print = True):
    if cmd != '':
        if do_print:
            print(cmd)
            sys.stdout.flush()
        if not options.no_execute:
            retval = os.system(cmd)
            if retval != 0 and exit_on_fail:
                print(f"fatal error: command '{cmd}' failed")
                sys.stdout.flush()
                script_exit(1)
            return retval
        return None

def patch(patchfile: str):
    cmd = f"patch -Np1 -i {patchfile}"
    print(f"\n*** -> {cmd}")
    sys.stdout.flush()
    if not options.no_execute:
        retval = os.system(cmd)
        if retval != 0:
            print(f"fatal error: patch '{patchfile}' failed")
            sys.stdout.flush()
            script_exit(1)

def enter_srcdir(directory: str):
    print(f"cd {directory}")
    sys.stdout.flush()
    if not options.no_execute:
        try:
            os.chdir(directory)
        except Exception:
            print(f"fatal error: can't change to '{directory}' folder.")
            sys.stdout.flush()
            script_exit(1)

def leave_srcdir():
    print("cd ..")
    sys.stdout.flush()
    if not options.no_execute:
        os.chdir("..")

def gentoo_patches(firefox_folder: str, common_srcdir: str):

    enter_srcdir(firefox_folder)

    gentoo_path = join(common_srcdir, 'patches/gentoo')
    patch_files = [f for f in os.listdir(gentoo_path) if isfile(join(gentoo_path, f))]

    blacklist_patches = []
    blacklist_filepath = join(common_srcdir, 'gentoo-patch-blacklist.txt')
    if isfile(blacklist_filepath):
        with open(blacklist_filepath, 'r') as f:
            blacklist_patches = f.read().splitlines()

    for patch_file in patch_files:
        if any(denied_patch in patch_file for denied_patch in blacklist_patches):
            continue
        patch_filename = join(gentoo_path, patch_file)
        patch(patch_filename)

    leave_srcdir()

def cachy_patches(firefox_folder: str, common_srcdir: str, settings_srcdir: str):

    enter_srcdir(firefox_folder)

    # copy branding files..
    exec('cp -r {0} .'.format(join(common_srcdir, 'source_files/browser')))

    # copy the right search-config.json file
    exec('cp -v {0} services/settings/dumps/main/search-config.json'.format(join(common_srcdir, 'source_files/search-config.json')))

    # apply dbus names patch, to have dbus name exposed as cachy instead of mozilla
    patch(join(common_srcdir, 'patches/dbus_name.patch'))

    # apply patch to have correct profiles folder name
    patch(join(common_srcdir, 'patches/mozilla_dirs.patch'))

    # apply patch to fix wrong profile dir on Firefox 137
    # see https://codeberg.org/librewolf/source/commit/0ce00ca673e7311f2ce35d4815d5a1bb2db3bbce
    patch(join(common_srcdir, 'patches/moz-configure.patch'))

    #
    # Apply most recent `settings` repository files.
    #

    exec('mkdir -p lw')
    enter_srcdir('lw')
    exec('cp -v {0} .'.format(join(settings_srcdir, 'cachyos.cfg')))
    exec('cp -v {0} .'.format(join(settings_srcdir, 'distribution/policies.json')))
    exec('cp -v {0} .'.format(join(settings_srcdir, 'defaults/pref/local-settings.js')))
    leave_srcdir()



    #
    # pref-pane patches
    #

    # 2) new files
    exec('cp {0} browser/themes/shared/preferences/category-cachy-browser.svg'.format(join(common_srcdir, 'patches/pref-pane/category-cachy-browser.svg')))
    exec('cp {0} browser/themes/shared/preferences/cachy-browser.css'.format(join(common_srcdir, 'patches/pref-pane/cachy-browser.css')))
    exec('cp {0} browser/components/preferences/cachy-browser.inc.xhtml'.format(join(common_srcdir, 'patches/pref-pane/cachy-browser.inc.xhtml')))
    exec('cp {0} browser/components/preferences/cachy-browser.js'.format(join(common_srcdir, 'patches/pref-pane/cachy-browser.js')))
    # 3) append our locale string values to preferences.ftl
#    exec('cat browser/locales/en-US/browser/preferences/preferences.ftl {0} > preferences.ftl'.format(join(common_srcdir, 'patches/pref-pane/preferences.ftl')))
#    exec('mv preferences.ftl browser/locales/en-US/browser/preferences/preferences.ftl')

    # generate locales
    #exec("bash ../scripts/generate-locales.sh")

    leave_srcdir()

#
# Main functionality in this script..
#

if len(args) != 3:
    sys.stderr.write(f'Invalid usage! {sys.argv[0]} <firefox folder> <cachy-browser-common folder> <cachy-browser-settings folder>\n')
    sys.exit(1)

firefox_folder = args[0]
cachy_common_folder = args[1]
cachy_settings_folder = args[2]

if not os.path.exists(join(firefox_folder, 'configure.py')):
    sys.stderr.write('error: folder doesn\'t look like a Firefox folder.\n')
    sys.exit(1)

print('---- Gentoo patches')
gentoo_patches(firefox_folder, cachy_common_folder)

print('---- Cachy patches')
cachy_patches(firefox_folder, cachy_common_folder, cachy_settings_folder)

sys.exit(0) # ensure 0 exit code

