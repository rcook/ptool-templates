{%- set imports = [
    "{}.Types exposing (User)".format(module_name),
    "RemoteData exposing (WebData)"
    ] -%}
{{elm_copyright}}

module {{module_name}}.Msg exposing (Msg(..))

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

type Msg
    = GetUsers
    | UsersResponse (WebData (List User))
