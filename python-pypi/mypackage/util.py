#{{py_copyright}}
def some_function(s):
    """
    >>> some_function("and")
    'before_and_after'
    """
    return "before_{}_after".format(s)
