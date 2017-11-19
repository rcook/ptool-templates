import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..", )))
from _ptool.util import *

def ptool_register(ctx):
    ctx.globals["module_name"] = python_module_name(ctx.project_name)
