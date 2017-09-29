{%- set imports = [
    "Date exposing (Date)",
    "Date.Extra.Config.Config_en_us exposing (config)",
    "Date.Extra.Format as Format exposing (format)"
    ] -%}
{{elm_copyright}}

module {{module_name}}.Util
    exposing
        ( dateString
        , dropTrailingPathSeparator
        , hasTrailingPathSeparator
        )

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

hasTrailingPathSeparator : String -> Bool
hasTrailingPathSeparator =
    String.endsWith "/"


dropTrailingPathSeparator : String -> String
dropTrailingPathSeparator s =
    if hasTrailingPathSeparator s then
        let
            n =
                String.length s
        in
        String.slice 0 (n - 1) s
    else
        s


dateString : Date -> String
dateString date =
    format config
        config.format.date
        date

