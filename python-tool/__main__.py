{{py_copyright}}
from __future__ import print_function
import argparse
import os
import sys

from {{module_name}} import __description__, __project_name__, __version__
from {{module_name}}.config import Config

def _do_info(config, args):
    print("The \"info\" command")
    print("args={}".format(args))

def _main(argv=None):
    if argv is None:
        argv = sys.argv[1:]

    config_dir = os.path.abspath(os.path.expanduser(os.environ.get("{{ project_name | underscore | upper }}_DIR", "~/.{{project_name}}")))
    config = Config(config_dir)

    parser = argparse.ArgumentParser(prog=__project_name__, description=__description__)
    parser.add_argument("--version", action="version", version="{} version {}".format(__project_name__, __version__))

    subparsers = parser.add_subparsers(help="subcommand help")

    info_parser = subparsers.add_parser("info", help="Show some other information")
    info_parser.set_defaults(func=_do_info)

    args = parser.parse_args(argv)
    args.func(config, args)

if __name__ == "__main__":
    _main()
