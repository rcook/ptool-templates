{%- set imports = [
    "Date exposing (Date)",
    "Json.Decode exposing (Decoder, andThen, fail, string, succeed)"
    ] -%}
{{elm_copyright}}

module {{module_name}}.Decode exposing (decodeDate)

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

convertDate : String -> Decoder Date
convertDate raw =
    case Date.fromString raw of
        Ok date ->
            succeed date

        Err error ->
            fail error


date : Decoder Date
date =
    string |> andThen convertDate

