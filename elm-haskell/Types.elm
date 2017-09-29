{%- set imports = [
    "{}.Types exposing (Flags)".format(module_name)
    ] -%}
{{elm_copyright}}

module {{module_name}}.Types exposing (Flags)

{% for i in imports | sort -%}
import {{i}}
{% endfor %}
import Date exposing (Date)


type alias Flags =
    { logoPath : String
    , apiRootUrl : String
    }

