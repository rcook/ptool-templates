# {{project_name}} by {{author}}

C# application with app built using MSBuild or [xbuild][xbuild]

## Clone repository

```
git clone {{ project_name | git_url(git_server) }}
```

## Build

```
msbuild {{project_name}}.csproj /t:Build
```

## Licence

Released under [MIT License][licence]

[licence]: LICENSE
[xbuild]: http://www.mono-project.com/docs/tools+libraries/tools/xbuild/