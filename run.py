#!/usr/bin/env python
from __future__ import print_function
import argparse
import doctest
import imp
import os
import sys
import unittest

from ptool.template_util import load_template_module
from pyprelude.file_system import make_path

_PTOOLLIB_MODULE_NAME = "ptoollib"

def _get_test_suite(module):
    try:
        return doctest.DocTestSuite(module)
    except ValueError:
        return

def _template_dirs(start_dir, args):
    if len(args.template_dirs) > 0:
        return args.template_dirs

    template_dirs = []
    for i in os.listdir(start_dir):
        path = make_path(start_dir, i)
        if os.path.isdir(path):
            template_dirs.append(path)

    return template_dirs

def _do_test(start_dir, args):
    suite = unittest.TestSuite()

    if len(args.template_dirs) == 0:
        ptoollib_dir = make_path(os.path.dirname(__file__), _PTOOLLIB_MODULE_NAME)
        for i in os.listdir(ptoollib_dir):
            path = make_path(ptoollib_dir, i)
            if os.path.isfile(path) and path.endswith(".py"):
                module_name = "{}.{}".format(_PTOOLLIB_MODULE_NAME, os.path.basename(path))
                module = imp.load_source(module_name, path)
                tests = _get_test_suite(module)
                if tests is not None:
                    suite.addTests(tests)

    for template_dir in _template_dirs(start_dir, args):
        module = load_template_module(template_dir)
        tests = _get_test_suite(module)
        if tests is not None:
            suite.addTests(tests)

    unittest.TextTestRunner(verbosity=2).run(suite)

def _do_main(start_dir, args):
    load_template_module(args.template_dir, "__main__")

def _main(argv=None):
    if argv is None:
        argv = sys.argv[1:]

    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers()

    test_parser = subparsers.add_parser("test", help="Run tests")
    test_parser.set_defaults(func=_do_test)
    test_parser.add_argument("template_dirs", metavar="TEMPLATEDIRS", type=make_path, nargs="*")

    main_parser = subparsers.add_parser("main", help="Run main entrypoint")
    main_parser.set_defaults(func=_do_main)
    main_parser.add_argument("template_dir", metavar="TEMPLATEDIR", type=make_path)

    args = parser.parse_args(argv)
    args.func(os.getcwd(), args)

if __name__ == "__main__":
    _main()
