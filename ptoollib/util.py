##################################################
# Copyright (C) 2017, All rights reserved.
##################################################

def domain_file_path(s):
    """
    >>> domain_file_path("aaa.bbb.ccc")
    'ccc/bbb/aaa'
    """
    return "/".join(reversed(s.split(".")))

def reversed_domain(s):
    """
    >>> reversed_domain("aaa.bbb.ccc")
    'ccc.bbb.aaa'
    """
    return ".".join(reversed(s.split(".")))

def python_module_name(s):
    """
    >>> python_module_name("aaa.bbb.ccc")
    'aaa.bbb.ccc'
    """
    return s.replace("_", "").replace("-", "")

def module_name(ctx, s):
    return "".join(map(lambda s: s.title(), ctx.tokenize(s)))
