import argparse
import datetime
import shutil
import string
import yaml
from pyprelude.file_system import *
from pyprelude.temp_util import *

class FileInfo(object):
    def __init__(self, source_path, output_path_template, is_preprocess):
        self._source_path = source_path
        self._output_path_template = output_path_template
        self._is_preprocess = is_preprocess
        self._content = None
        self._keys = None

    @property
    def keys(self):
        if self._keys is None:
            keys = []
            keys.extend(_template_tokens(self._output_path_template))
            if self._is_preprocess:
                keys.extend(_template_tokens(self.content))

            self._keys = sorted(list(set(keys)))

        return self._keys

    @property
    def content(self):
        if not self._is_preprocess:
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

        if self._is_preprocess:
            with open(self._source_path, "rt") as f:
                template = string.Template(f.read())

            with open(target_path, "wt") as f:
                f.write(template.substitute(values))
        else:
            shutil.copyfile(self._source_path, target_path)

def _home_dir():
    return os.path.expanduser("~")

def read_file(obj, template_dir):
    if isinstance(obj, dict):
        path = obj["path"]
        output_path_template = obj.get("output-path", path)
        is_preprocess = obj.get("preprocess", False)
        source_path = make_path(template_dir, path)
        return FileInfo(source_path, output_path_template, is_preprocess=is_preprocess)
    elif isinstance(obj, str):
        source_path = make_path(template_dir, obj)
        return FileInfo(source_path, obj, is_preprocess=False)
    else:
        raise RuntimeError("Unsupported node type {}".format(type(obj)))

def _template_tokens(s):
    tokens = []
    for _, a, b, _ in string.Template.pattern.findall(s):
        assert(len(a) == 0 and len(b) > 0 or len(a) > 0 and len(b) == 0)
        tokens.append(a if len(b) == 0 else b)
    return tokens

def _template_values(args):
    values = {
        "copyright_year": str(datetime.datetime.now().year),
        "project_name": os.path.basename(args.output_dir)
    }

    user_yaml_path = make_path(_home_dir(), ".project.yaml")
    if os.path.isfile(user_yaml_path):
        with open(user_yaml_path, "rt") as f:
            values.update(yaml.load(f))

    for key, value in args.key_value_pairs:
        values[key] = value

    return values

def _main_inner(script_dir, repo_dir, args):
    template_dir = make_path(repo_dir, args.template_name)
    yaml_path = make_path(template_dir, "project.yaml")

    if not os.path.isfile(yaml_path):
        raise RuntimeError("No template \"{}\" directory found under {}".format(args.template_name, repo_dir))

    with open(yaml_path, "rt") as f:
        obj = yaml.load(f)

    values = _template_values(args)
    for key, value in args.key_value_pairs:
        values[key] = value

    files = map(lambda o: read_file(o, template_dir), obj["files"])

    commands = obj["commands"]

    unsorted_keys = []
    for file in files:
        unsorted_keys.extend(file.keys)
    for command in commands:
        unsorted_keys.extend(_template_tokens(command))

    keys = sorted(list(set(unsorted_keys)))

    missing_keys = []
    for key in keys:
        if key not in values:
            missing_keys.append(key)

    if len(missing_keys) > 0:
        raise RuntimeError("Need values for {}".format(", ".join(missing_keys)))

    for file in files:
        file.generate(values, args.output_dir)

    for command in commands:
        with temp_cwd(args.output_dir):
            os.system(command)

def _parse_key_value_pair(s):
    fragments = s.split("=")
    if len(fragments) != 2 or len(fragments[0]) < 1:
        raise argparse.ArgumentTypeError("Must be a key-value pair")
    return fragments[0], fragments[1]

def _main():
    parser = argparse.ArgumentParser(description="Create project from template")
    parser.add_argument(
        "template_name",
        metavar="TEMPLATENAME",
        type=str,
        help="Template name")
    parser.add_argument(
        "output_dir",
        metavar="OUTPUTDIR",
        type=make_path,
        help="Project output directory")
    parser.add_argument(
        "key_value_pairs",
        metavar="KEYVALUEPAIRS",
        type=_parse_key_value_pair,
        nargs="*",
        help="Key-value pairs for substitutions in templates")
    args = parser.parse_args()

    script_dir = make_path(os.path.dirname(__file__))
    repo_dir = make_path(os.path.dirname(script_dir))
    _main_inner(script_dir, repo_dir, args)

if __name__ == "__main__":
    _main()
