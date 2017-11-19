def _make_namespace(ctx, s):
    return "_".join(ctx.tokenize(s))

def ptool_register(ctx):
    ctx.globals["namespace"] = _make_namespace(ctx, ctx.project_name)
