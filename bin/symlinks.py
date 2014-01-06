#! /usr/bin/env python

import os
import fnmatch

def link(source, dest):
    try:
        if not os.path.exists(dest):
            print("linking " + source + " to " + dest)
            os.symlink(source,dest)
    except:
        print("fail")

def dotlink(source):
    dest = os.environ['HOME'] + "/." + os.path.basename(source.split('.symlink')[0])
    if os.path.exists(dest):
        current_target = os.path.realpath(dest)
        if current_target != source:
            link(source,dest)
        else:
            print("skipping " + source + " already links to " + dest)
    else:
        link(source,dest)

def find(pattern, path):
    result = []
    for root, dirs, files in os.walk(path):
        for name in files:
            if fnmatch.fnmatch(name, pattern):
                result.append(os.path.join(root, name))
        for name in dirs:
            if fnmatch.fnmatch(name, pattern):
                result.append(os.path.join(root, name))
    return result

def setup():
    dotfiles_root = os.environ['HOME'] + '/dotfiles'
    print("Finding linkables...")
    linkables = find('*.symlink', dotfiles_root)
    print("Done.")
    for x in linkables:
        dotlink(x)


