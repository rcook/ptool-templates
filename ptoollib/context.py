##################################################
# Copyright (C) 2018, All rights reserved.
##################################################

class Context(object):
    def __init__(self, globals={}, filters={}):
        self._globals = globals
        self._filters = filters

    def __getattr__(self, name):
        return self._globals[name]

    @property
    def globals(self): return self._globals

    @property
    def filters(self): return self._filters
