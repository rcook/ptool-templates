# {{project_name}} by {{author}}

Java application with app built using Maven

## Clone repository

```
git clone {{ project_name | git_url(git_server) }}
```

## Build

```
mvn package
```

This builds and runs test before generating the output package.

## Run

```
java -cp target/{{project_name}}-1.0-SNAPSHOT.jar com.{{java_company_name}}.app.App
```

## Licence

Released under [MIT License][licence]
