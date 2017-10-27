#!/usr/bin/env python
#{{py_copyright}}
from setuptools import setup

setup(
    name="{{project_name}}",
    version="0.1",
    description="My package",
    setup_requires=["setuptools-markdown"],
    long_description_markdown_filename="README.md",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 2.7",
    ],
    url="{{ project_name | git_url(git_server) }}",
    author="Richard Cook",
    author_email="rcook@rcook.org",
    license="MIT",
    packages=["{{project_name}}"],
    entry_points={
        "console_scripts": [
            "{{project_name}} = {{project_name}}.__main__:main"
        ]
    },
    include_package_data=True,
    test_suite="{{project_name}}.tests.suite",
    zip_safe=False)
