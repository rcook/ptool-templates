def _make_filter(ctx, body):
    b = eval(body)
    return lambda *args, **kwargs: b(ctx, *args, **kwargs)

def _to_env_project_name(ctx, s):
    return "_".join(map(lambda s: s.upper(), ctx.tokenize(s)))

def _to_module_name(ctx, s):
    return "".join(map(lambda s: s.title(), ctx.tokenize(s)))

def _to_paths_module_name(ctx, s):
    return "Paths_{}".format("_".join(map(lambda s: s.lower(), ctx.tokenize(s))))

def ptool_register(ctx):
    ctx.filters["child_module_name"] = _make_filter(
        ctx,
        "lambda ctx, s, module_suffix=\"\": \"{}{}.{}\".format(ctx.module_name, module_suffix, s)")

    project_name = ctx.globals["project_name"]
    ctx.globals["env_project_name"] = _to_env_project_name(ctx, project_name)
    ctx.globals["module_name"] = _to_module_name(ctx, project_name)
    ctx.globals["paths_module_name"] = _to_paths_module_name(ctx, project_name)
