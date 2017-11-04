{{py_copyright}}
import os
import re

from setuptools import find_packages, setup

def _read_properties():
    init_path = os.path.abspath(os.path.join("{{module_name}}", "__init__.py"))
    regex = re.compile("^\\s*__(?P<key>.*)__\\s*=\\s*\"(?P<value>.*)\"\\s*$")
    with open(init_path, "rt") as f:
        props = {}
        for line in f.readlines():
            m = regex.match(line)
            if m is not None:
                props[m.group("key")] = m.group("value")

    return props

props = _read_properties()
version = props["version"]
description = props["description"]

setup(
    name="{{project_name}}",
    version=version,
    description=description,
    setup_requires=["setuptools-markdown"],
    long_description_markdown_filename="README.md",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 2.7",
    ],
    url="{{project_name | git_url(git_server) }}",
    author="{{author}}",
    author_email="{{author_email}}",
    license="MIT",
    packages=find_packages(),
    install_requires=[
        # TODO: Add dependencies here: requirements.txt will use this list too
    ],
    entry_points={
        "console_scripts": [
            "{{project_name}} = {{module_name}}.__main__:_main"
        ]
    },
    include_package_data=True,
    test_suite="{{module_name}}.tests.suite",
    zip_safe=False)
