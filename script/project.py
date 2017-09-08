#!/usr/bin/env python
# -----------------------------------------------------------------------------
#
# Copyright (C) 2017, Richard Cook. All rights reserved.
#
# -----------------------------------------------------------------------------

from __future__ import print_function
import argparse
import datetime
import shutil
import string
import sys
import yaml

from pyprelude.file_system import *
from pyprelude.temp_util import *

from projectlib.arg_util import parse_key_value_pair
from projectlib.git_util import git_execute_attribute, git_symlink
from projectlib.lang_util import safe_namespace
from projectlib.template_util import template_tokens
from projectlib.util import home_dir, remove_dir

_PROJECT_YAML_FILE_NAME = "project.yaml"

class Informational(Exception):
    def __init__(self, message):
        super(Informational, self).__init__(message)

class FileInfo(object):
    def __init__(self, source_path, output_path_template, is_template):
        self._source_path = source_path
        self._output_path_template = output_path_template
        self._is_template = is_template
        self._content = None
        self._keys = None

    @property
    def keys(self):
        if self._keys is None:
            self._keys = template_tokens(self._output_path_template, self.content if self._is_template else "")
        return self._keys

    @property
    def content(self):
        if not self._is_template:
            raise RuntimeError("Not a template")

        if self._content is None:
            with open(self._source_path, "rt") as f:
                self._content = f.read()

        return self._content

    def generate(self, values, output_dir):
        t0 = string.Template(self._output_path_template)
        t1 = t0.substitute(values)

        target_path = make_path(output_dir, t1)
        target_dir = os.path.dirname(target_path)

        if not os.path.isdir(target_dir):
            os.makedirs(target_dir)

        if self._is_template:
            with open(self._source_path, "rt") as f:
                template = string.Template(f.read())

            with open(target_path, "wt") as f:
                f.write(template.substitute(values))
        else:
            shutil.copyfile(self._source_path, target_path)

class SimpleCommandInfo(object):
    def __init__(self, command_template):
        self._command_template = command_template
        self._keys = None

    @property
    def keys(self):
        if self._keys is None:
            self._keys = template_tokens(self._command_template)
        return self._keys

    def run(self, values):
        command = string.Template(self._command_template).substitute(values)
        if os.system(command) != 0:
            raise RuntimeError("Command \"{}\" failed".format(command))

class GitExecuteAttributeCommandInfo(object):
    def __init__(self, path_template):
        self._path_template = path_template
        self._keys = None

    @property
    def keys(self):
        if self._keys is None:
            self._keys = template_tokens(self._path_template)
        return self._keys

    def run(self, values):
        path = string.Template(self._path_template).substitute(values)
        git_execute_attribute(os.getcwd(), path)

class GitSymlinkCommandInfo(object):
    def __init__(self, source_path_template, target_path_template):
        self._source_path_template = source_path_template
        self._target_path_template = target_path_template
        self._keys = None

    @property
    def keys(self):
        if self._keys is None:
            self._keys = template_tokens(self._source_path_template, self._target_path_template)
        return self._keys

    def run(self, values):
        source_path = string.Template(self._source_path_template).substitute(values)
        target_path = string.Template(self._target_path_template).substitute(values)
        git_symlink(os.getcwd(), source_path, target_path)

def _read_file(obj, template_dir):
    if isinstance(obj, dict):
        path = obj["path"]
        output_path_template = obj.get("output-path", path)
        is_template = obj.get("preprocess", False)
        source_path = make_path(template_dir, path)
        return FileInfo(source_path, output_path_template, is_template=is_template)
    elif isinstance(obj, str):
        source_path = make_path(template_dir, obj)
        return FileInfo(source_path, obj, is_template=False)
    else:
        raise RuntimeError("Unsupported node type {}".format(type(obj)))

def _read_command(obj):
    if isinstance(obj, dict):
        t = list(obj)
        if len(t) != 1:
            raise RuntimeError("Invalid command {}".format(obj))
        tool_name = t[0]
        if tool_name == "git-execute-attribute":
            o = obj["git-execute-attribute"]
            path_template = o["path"]
            return GitExecuteAttributeCommandInfo(path_template)
        elif tool_name == "git-symlink":
            o = obj["git-symlink"]
            source_path_template = o["source-path"]
            target_path_template = o["target-path"]
            return GitSymlinkCommandInfo(source_path_template, target_path_template)
        else:
            raise RuntimeError("Unsupported tool \"{}\"".format(tool_name))
    elif isinstance(obj, str):
        return SimpleCommandInfo(obj)
    else:
        raise RuntimeError("Unsupported command type {}".format(type(obj)))

def _template_values(args):
    project_name = os.path.basename(args.output_dir)
    values = {
        "copyright_year": str(datetime.datetime.now().year),
        "project_name": project_name,
        "namespace": safe_namespace(project_name)
    }

    user_yaml_path = make_path(home_dir(), ".project.yaml")
    if os.path.isfile(user_yaml_path):
        with open(user_yaml_path, "rt") as f:
            values.update(yaml.load(f))

    for key, value in args.key_value_pairs:
        values[key] = value

    return values

def _do_new(script_dir, repo_dir, args):
    if os.path.exists(args.output_dir):
        if args.force_overwrite:
            remove_dir(args.output_dir)
        else:
            raise Informational("Output directory \"{}\" already exists: force overwrite with --force".format(args.output_dir))

    template_dir = make_path(repo_dir, args.template_name)
    yaml_path = make_path(template_dir, _PROJECT_YAML_FILE_NAME)

    if not os.path.isfile(yaml_path):
        raise RuntimeError("No template \"{}\" directory found under {}".format(args.template_name, repo_dir))

    with open(yaml_path, "rt") as f:
        obj = yaml.load(f)

    values = _template_values(args)
    for key, value in args.key_value_pairs:
        values[key] = value

    files = map(lambda o: _read_file(o, template_dir), obj.get("files", []))
    commands = map(lambda o: _read_command(o), obj.get("commands", []))

    unsorted_keys = []
    for file in files:
        unsorted_keys.extend(file.keys)
    for command in commands:
        unsorted_keys.extend(command.keys)

    keys = sorted(list(set(unsorted_keys)))

    missing_keys = []
    for key in keys:
        if key not in values:
            missing_keys.append(key)

    if len(missing_keys) > 0:
        raise Informational("Provide values for {} in ~/.project.yaml or via command line".format(", ".join(map(lambda k: "\"{}\"".format(k), missing_keys))))

    for file in files:
        file.generate(values, args.output_dir)

    with temp_cwd(args.output_dir):
        for command in commands:
            command.run(values)

def _do_templates(script_dir, repo_dir, args):
    templates = []
    for item in sorted(os.listdir(repo_dir)):
        yaml_path = make_path(repo_dir, item, _PROJECT_YAML_FILE_NAME)
        if os.path.isfile(yaml_path):
            with open(yaml_path, "rt") as f:
                obj = yaml.load(f.read())

            templates.append((os.path.basename(item), obj.get("description", "(no description)")))

    width = 0
    for project_name, _ in templates:
        t = len(project_name)
        if t > width:
            width = t

    for project_name, description in templates:
        print("{}    {}".format(project_name.ljust(width), description))

def _main():
    parser = argparse.ArgumentParser(description="Create project from template")
    subparsers = parser.add_subparsers(help="subcommand help")

    new_parser = subparsers.add_parser("new", help="Create new project from template")
    new_parser.set_defaults(func=_do_new)
    new_parser.add_argument(
        "-f",
        "--force",
        dest="force_overwrite",
        action="store_true",
        help="Force overwrite of existing output directory")
    new_parser.add_argument(
        "template_name",
        metavar="TEMPLATENAME",
        type=str,
        help="Template name")
    new_parser.add_argument(
        "output_dir",
        metavar="OUTPUTDIR",
        type=make_path,
        help="Project output directory")
    new_parser.add_argument(
        "key_value_pairs",
        metavar="KEYVALUEPAIRS",
        type=parse_key_value_pair,
        nargs="*",
        help="Key-value pairs for substitutions in templates")

    templates_parser = subparsers.add_parser("templates", help="List available templates")
    templates_parser.set_defaults(func=_do_templates)

    args = parser.parse_args()

    script_dir = make_path(os.path.dirname(__file__))
    repo_dir = make_path(os.path.dirname(script_dir))

    try:
        args.func(script_dir, repo_dir, args)
    except Informational as e:
        print(e.message)
        sys.exit(1)

if __name__ == "__main__":
    _main()
