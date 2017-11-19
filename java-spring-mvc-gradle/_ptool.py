import inflection
import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..", )))
from _ptool.util import *

def ptool_register(ctx):
    java_domain = ctx.java_domain
    ctx.globals["domain_file_path"] = domain_file_path(java_domain)
    ctx.globals["reversed_domain"] = reversed_domain(java_domain)
    ctx.globals["package_base_name"] = inflection.camelize(inflection.underscore(ctx.project_name))
