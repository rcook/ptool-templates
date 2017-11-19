def _domain_file_path(s):
    return "/".join(reversed(s.split(".")))

def _reversed_domain(s):
    return ".".join(reversed(s.split(".")))

def ptool_register(ctx):
    ctx.globals["domain_file_path"] = _domain_file_path(ctx.globals["java_domain"])
    ctx.globals["reversed_domain"] = _reversed_domain(ctx.globals["java_domain"])
