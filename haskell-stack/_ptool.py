##################################################
# Copyright (C) 2017, All rights reserved.
##################################################

def _module_name(ctx, s):
    return "".join(map(lambda s: s.title(), ctx.tokenize(s)))

def ptool_register(ctx):
    """
    >>> from ptoollib.context import Context
    >>> globals = { "project_name": "xxx-yyy", "tokenize": lambda s: s.split("-") }
    >>> ctx = Context(globals)
    >>> ptool_register(ctx)
    >>> globals["module_name"]
    'XxxYyy'
    """
    ctx.globals["module_name"] = _module_name(ctx, ctx.project_name)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
