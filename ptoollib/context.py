##################################################
# Copyright (C) 2017, All rights reserved.
##################################################

class Context(object):
    def __init__(self, globals):
        self._globals = globals

    def __getattr__(self, name):
        return self._globals[name]

    @property
    def globals(self): return self._globals
