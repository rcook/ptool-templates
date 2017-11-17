def _make_namespace(ctx, s):
    return "_".join(ctx.tokenize(s))

def ptool_register(ctx, globals):
    globals["namespace"] = _make_namespace(ctx, globals["project_name"])
