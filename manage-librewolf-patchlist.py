#!/usr/bin/python

import optparse
from os.path import join

parser = optparse.OptionParser()
parser.add_option("-f", "--file",
                  dest = "filename",
                  help = "patch list file", 
                  metavar = "FILE")
parser.add_option('--exclude', dest = 'exclude', help='exclude needle strings', default=None)
options, args = parser.parse_args()

needle_list = [] if not options.exclude else options.exclude.split(',')
file_lines = []

with open(options.filename, 'r') as f:
    file_lines = f.read().splitlines()

new_lines = []
for line in file_lines:
    if any(needle in line for needle in needle_list):
        continue

    filename_split = line.split('/')
    if len(filename_split) == 2:
        new_filename = join('patches/librewolf', filename_split[1])
        new_lines.append(new_filename)
        continue
    if filename_split[1] == 'ui-patches':
        new_filename = join('patches/librewolf-ui', '/'.join(filename_split[2:]))
        new_lines.append(new_filename)
        continue

    new_lines.append(line)

with open(options.filename, 'w') as f:
    f.write('\n'.join(new_lines) + '\n')
