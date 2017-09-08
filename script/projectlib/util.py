# -----------------------------------------------------------------------------
#
# Copyright (C) 2017, Richard Cook. All rights reserved.
#
# -----------------------------------------------------------------------------

import os
import shutil
import stat

from pyprelude.process import *
from pyprelude.temp_util import *

def _is_path_writeable(path):
    return os.access(path, os.W_OK)

def _set_perm(path, perm):
    os.chmod(path, perm)

def _remove_dir_on_error(func, path, exc_info):
    if not _is_path_writeable(path):
        _set_perm(path, stat.S_IWUSR)
        func(path)
    else:
        raise

# TODO: Move into pyprelude: https://github.com/rcook/pyprelude/issues/2
def remove_dir(path):
    try:
        shutil.rmtree(path, onerror=_remove_dir_on_error)
    except WindowsError:
        with temp_dir() as d:
            status, output, error = execute("robocopy.exe", d, path, "/mir", can_fail=True)
            if status != 2:
                raise RuntimeError("robocopy failed with status {} (output={}, error={})".format(status, output, error))

        os.rmdir(path)

def home_dir():
    return os.path.expanduser("~")
