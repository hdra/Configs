#!/usr/bin/env python
import os
import shutil

excludes = [
  'readme.md',
  'install.py',
  '.git',
  '.gitignore',
  '.gitmodules',
  'sublime',
  'zsh',
  'vscode',
  'Brewfile',
]
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


def install_sublime(source, target):
    is_symlink = os.path.islink(target)
    if os.path.isdir(target) and not is_symlink:
        shutil.rmtree(target)
    if not is_symlink:
        os.symlink(source, target)


def install_vscode(source, target):
    if not os.path.exists(target):
        os.makedirs(target, exist_ok=True)
    for f in os.listdir(source):
        source_file = os.path.join(source, f)
        destination_file = os.path.join(target, f)
        if os.path.exists(destination_file) and not os.path.islink(destination_file):
            os.remove(destination_file)
        os.symlink(source_file, destination_file)


home = os.path.expanduser('~')
pwd = os.path.dirname(os.path.realpath(__file__))
iterate_and_install(pwd, home)

sublime_source = os.path.join(pwd, 'sublime/User')
sublime_target = os.path.join(home, 'Library/Application Support/Sublime Text/Packages/User')
os.makedirs(sublime_target)
install_sublime(sublime_source, sublime_target)

vscode_source = os.path.join(pwd, 'vscode')
vscode_target = os.path.join(home, 'Library/Application Support/Code/User')
os.makedirs(vscode_target)
install_vscode(vscode_source, vscode_target)
