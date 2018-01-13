##################################################
# Copyright (C) 2018, All rights reserved.
##################################################

from ptoollib.util import *

def ptool_register(ctx):
    """
    >>> from ptoollib.context import Context
    >>> globals = { "project_name": "xxx-yyy" }
    >>> ctx = Context(globals)
    >>> ptool_register(ctx)
    >>> globals["module_name"]
    'xxxyyy'
    >>> globals["project_name"]
    'xxx-yyy'
    """
    ctx.globals["module_name"] = python_module_name(ctx.project_name)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
