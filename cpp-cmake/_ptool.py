##################################################
# Copyright (C) 2017, All rights reserved.
##################################################

def _make_namespace(ctx, s):
    return "_".join(ctx.tokenize(s))

def ptool_register(ctx):
    """
    >>> from ptoollib.context import Context
    >>> globals = { "project_name": "xxx-yyy", "tokenize": lambda s: s.split("-") }
    >>> ctx = Context(globals)
    >>> ptool_register(ctx)
    >>> globals["namespace"]
    'xxx_yyy'
    """
    ctx.globals["namespace"] = _make_namespace(ctx, ctx.project_name)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
