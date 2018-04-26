#!/bin/env python3

from common import pushd, popd, Package, argv_parse, setup_enviroment
from subprocess import check_call as run, check_output
from os.path import join, getmtime, exists, basename, dirname

config, pkgs = argv_parse()
while len(pkgs):
    pkg = pkgs.pop()
    pushd(pkg.directory)
    fname = pkg.filename()
    if not exists(fname) or getmtime(pkg.pkgbuild) > getmtime(fname):
        run(["makepkg", "-Cfp", pkg.pkgbuild])
        run(["yaourt", "-U", fname])
    popd()
    for p in pkgs:
        if pkg.name in p.dependencies:
            p.dependencies.remove(pkg.name)
    pkgs.sort(key=Package.sortkey, reverse=True)


