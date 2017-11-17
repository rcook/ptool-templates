def _domain_file_path(s):
    return "/".join(reversed(s.split(".")))

def _reversed_domain(s):
    return ".".join(reversed(s.split(".")))

def ptool_register(ctx, globals):
    globals["domain_file_path"] = _domain_file_path(globals["java_domain"])
    globals["reversed_domain"] = _reversed_domain(globals["java_domain"])
