#!/usr/bin/python
import sys
import os
from os.path import isfile, join

if len(sys.argv) < 4:
    print(f"Invalid usage!\n {sys.argv[0]} <path with files> <needle string> <replacement string>")
    sys.exit(1)

PATH_WITH_FILES = sys.argv[1]
NEEDLE_STR = sys.argv[2]
REPLACEMENT_STR = sys.argv[3]

files = [f for f in os.listdir(PATH_WITH_FILES) if isfile(join(PATH_WITH_FILES, f))]
for file in files:
    new_filename = join(PATH_WITH_FILES, file.replace(NEEDLE_STR, REPLACEMENT_STR))
    os.rename(join(PATH_WITH_FILES, file), new_filename)
    print(f"renamed '{file}' -> '{new_filename}'")
