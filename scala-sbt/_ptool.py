##################################################
# Copyright (C) 2018, All rights reserved.
##################################################

from ptoollib.util import *

def ptool_register(ctx):
    """
    >>> from ptoollib.context import Context
    >>> globals = { "project_name": "xxx-yyy", "tokenize": lambda s: s.split("-") }
    >>> ctx = Context(globals)
    >>> ptool_register(ctx)
    >>> globals["module_name"]
    'XxxYyy'
    """
    ctx.globals["module_name"] = module_name(ctx, ctx.project_name)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
