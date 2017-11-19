def _module_name(ctx, s):
    return "".join(map(lambda s: s.title(), ctx.tokenize(s)))

def ptool_register(ctx):
    ctx.globals["module_name"] = _module_name(ctx, ctx.globals["project_name"])
