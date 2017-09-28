{%- set imports = [
    "{}.Types exposing (User)".format(module_name),
    "Date exposing (Date)",
    "Json.Decode exposing (Decoder, andThen, fail, int, list, string, succeed)",
    "Json.Decode.Pipeline exposing (decode, required)"
    ] -%}
{{elm_copyright}}

module {{module_name}}.Decode
    exposing
        ( date
        , user
        , users
        )

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

users : Decoder (List User)
users =
    list user


user : Decoder User
user =
    decode User
        |> required "email" string
        |> required "age" int
        |> required "name" string
        |> required "registrationDate" date


date : Decoder Date
date =
    let
        convert : String -> Decoder Date
        convert raw =
            case Date.fromString raw of
                Ok date ->
                    succeed date

                Err error ->
                    fail error
    in
    string |> andThen convert

