#! /usr/bin/env python

import os, fnmatch

def link(source, dest):
    print("LINK ", source, " to ", dest)
    os.symlink(source,dest)

def dotlink(source):
    dest = os.environ['HOME'] + "/." + os.path.basename(source.split('.symlink')[0])
    if os.path.exists(dest):
        current_target = os.path.realpath(dest)
        if current_target != source:
            link(source,dest)
        else:
            print("SKIP", dest, " already points to ", source)
    else:
        link(source,dest)

def find(pattern, path):
    result = []
    for root, dirs, files in os.walk(path):
        for name in files:
            if fnmatch.fnmatch(name, pattern):
                result.append(os.path.join(root, name))
    return result

def main():
    dotfiles_root = os.environ['HOME'] + '/dotfiles'
    print("finding linkables")
    linkables = find('*.symlink', dotfiles_root)
    for x in linkables:
        dotlink(x)

main()
