from ptoollib.util import *

def ptool_register(ctx):
    """
    >>> from ptoollib.context import Context
    >>> globals = { "java_domain": "aaa.bbb.ccc" }
    >>> ctx = Context(globals)
    >>> ptool_register(ctx)
    >>> globals["domain_file_path"]
    'ccc/bbb/aaa'
    >>> globals["java_domain"]
    'aaa.bbb.ccc'
    >>> globals["reversed_domain"]
    'ccc.bbb.aaa'
    """
    java_domain = ctx.java_domain
    ctx.globals["domain_file_path"] = domain_file_path(java_domain)
    ctx.globals["reversed_domain"] = reversed_domain(java_domain)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
