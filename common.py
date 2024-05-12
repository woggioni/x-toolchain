#!/bin/env python3
import sys
import argparse
from glob import glob
from os import environ, getcwd, chdir
from subprocess import run, check_output
from os.path import join, dirname, splitext, basename, exists, realpath
from pickle import dump, load

class Package:

    def __init__(self, **kwargs):
        for key,value in kwargs.items():
            self.__dict__[key] = value

    def __repr__(self):
        return self.__dict__.__repr__()

    def filename(self):
        return f'{self.name}-{self.version}-{self.rel}-{self.arch}.pkg.tar.xz'

    def sortkey(self):
        return len(self.dependencies)

def _init():
    dir_stack = []

    def pushd(*args):
        dir_stack.append(getcwd())
        ndir = realpath(join(*args))
        chdir(ndir)

    def popd():
        odir = dir_stack.pop()
        chdir(odir)

    return pushd, popd


pushd, popd = _init()


def argv_parse():
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--cpu', help='cpu name', metavar='CPU')
    parser.add_argument("-v", "--vendor", help="vendor name", metavar='VENDOR')
    parser.add_argument("-s", "--system", help="system name", metavar='SYSTEM')
    parser.add_argument("-t", "--triplet", help="triplet name", metavar='CPU-VENDOR-SYSTEM')
    parser.add_argument("-l", "--list", help="list all available toolchains", action='store_true')
    parser.add_argument("-i", "--input-build-file", help="path to a dependency resolution file", metavar='build.pickle')
    parser.add_argument("-o", "--output-build-file", help="path to a dependency resolution file", metavar='build.pickle')
    args = parser.parse_args()

    if args.input_build_file:
        config, pkgs = load(open(args.input_build_file, 'rb'))
        setup_enviroment(**config)
        return config, pkgs
    elif args.triplet or (args.cpu and args.vendor and args.system):
        triplet = args.triplet or f'{args.xpu}-{args.vendor}-{args.system}'
        cursor = 0
        result = []
        for i in range(3):
            if cursor < 0:
                sys.stderr.write(f"Invalid triplet: {triplet}\n")
            if len(result) < 2:
                next = triplet.find('-', cursor)
                result.append(triplet[cursor:next])
            else:
                result.append(triplet[cursor:])
            cursor=next+1
        cpu, vendor, os = result
        config = join(dirname(__file__), "toolchain", triplet + ".config")
        if not exists(config):
            sys.stderr.write(f'Toolchain {triplet} does not exists\n')
            sys.exit(-1)
        else:
            config = {
                "triplet": triplet,
                "cpu" : cpu,
                "vendor" : vendor,
                "os" : os,
                "config_path" : config
            }
            setup_enviroment(**config)
            pkgs = {}
            for pkgbuild in [join(dirname(__file__),'toolchain/PKGBUILD')] + glob(dirname(__file__) + '/packages/*/PKGBUILD*'):
                pkgdir = dirname(pkgbuild)
                fname = basename(pkgbuild)
                out = check_output(
                    ["bash", "-c", f'cd {dirname(pkgbuild)}; source {fname}; echo "${{depends[@]}} ${{makedepends[@]}} ${{pkgname}} ${{pkgver}} ${{pkgrel}} ${{arch}}"']).decode('utf-8').split()
                arch = out.pop()
                rel = out.pop()
                version = out.pop()
                name = out.pop()
                deps = set(dep for dep in out if dep.startswith(config['triplet']))
                pkgs[name] = Package(name=name, version=version, rel=rel, arch=arch, directory=pkgdir, pkgbuild=fname, dependencies=deps)

            pkgs = list(pkgs.values())
            pkgs.sort(key=Package.sortkey, reverse=True)
            if args.output_build_file:
                dump((config, pkgs), open(args.output_build_file, 'wb'))
            return (config, pkgs)
    elif args.list:
        for config in glob(join(dirname(__file__), "toolchain") + "/*.config"):
            print(splitext(basename(config))[0])
        sys.exit(0)
    else:
        sys.stderr.write('You must either specify a whole triplet or all of cpu, vendor and system\n')
        sys.exit(-1)


def setup_enviroment(cpu=None, vendor=None, os=None, triplet=None, **kwargs):
    target = f"{cpu}-{vendor}-{os}"
    prefix = f"/opt/x-tools/{target}"
    environ["_cpu"] = cpu
    environ["_vendor"] = vendor
    environ["_os"] = os
    environ["_target"] = target
    environ["_prefix"] = prefix
    environ["PATH"] = f'{environ["_prefix"]}/bin:{environ["PATH"]}'


if __name__ == '__main__':
    setup_enviroment(**argv_parse())
    run(['bash'])
