#!/usr/bin/env python
import os

excludes = ['readme.md', 'install.py', '.git', '.gitignore', '.gitmodules']
# container directory. don't symlink directly, symlinks the contents instead
containers = ['.config']


def iterate_and_install(directory, target_dir):
    for f in [f for f in os.listdir(directory) if f not in excludes]:
        if os.path.isdir(f) and f in containers:
            iterate_and_install(os.path.join(directory, f), os.path.join(target_dir, f))
        else:
            source = os.path.join(directory, f)
            destination = os.path.join(target_dir, f)
            if os.path.isfile(destination) or os.path.isdir(destination):
                print("{0} exists. skipping {1}".format(destination, f))
            else:
                print("linking {0} to {1}".format(f, destination))
                os.symlink(source, destination)


home = os.path.expanduser('~')
pwd = os.path.dirname(os.path.realpath(__file__))
iterate_and_install(pwd, home)
