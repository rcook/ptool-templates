##################################################
# Copyright (C) 2018, All rights reserved.
##################################################

from ptoollib.util import *

def _to_env_project_name(ctx, s):
    return "_".join(map(lambda s: s.upper(), ctx.tokenize(s)))

def _to_paths_module_name(ctx, s):
    return "Paths_{}".format("_".join(map(lambda s: s.lower(), ctx.tokenize(s))))

def ptool_register(ctx):
    """
    >>> from ptoollib.context import Context
    >>> globals = { "project_name": "xxx-yyy", "tokenize": lambda s: s.split("-") }
    >>> filters = {}
    >>> ctx = Context(globals, filters)
    >>> ptool_register(ctx)
    >>> globals["env_project_name"]
    'XXX_YYY'
    >>> globals["module_name"]
    'XxxYyy'
    >>> globals["paths_module_name"]
    'Paths_xxx_yyy'
    >>> filters["child_module_name"]("Foo", "App")
    'XxxYyyApp.Foo'
    """
    project_name = ctx.project_name
    ctx.globals["env_project_name"] = _to_env_project_name(ctx, project_name)
    ctx.globals["module_name"] = module_name(ctx, project_name)
    ctx.globals["paths_module_name"] = _to_paths_module_name(ctx, project_name)

    ctx.filters["child_module_name"] = \
        lambda s, module_suffix="": "{}{}.{}".format(ctx.module_name, module_suffix, s)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
