{%- set imports = [
    "{}.Types exposing (Flags, User)".format(module_name),
    "{}.Util exposing (dropTrailingPathSeparator)".format(module_name),
    "RemoteData exposing (RemoteData(..), WebData)"
    ] -%}
{{elm_copyright}}

module {{module_name}}.Model exposing (Model, initModel)

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

type alias Model =
    { message : String
    , logoPath : String
    , apiRootUrl : String
    , users : WebData (List User)
    , requestCount : Int
    , showSpinner : Bool
    }


initModel : Flags -> ( Model, Cmd msg )
initModel flags =
    ( { message = "{{project_name}} is working!"
      , logoPath = flags.logoPath
      , apiRootUrl = dropTrailingPathSeparator flags.apiRootUrl
      , users = NotAsked
      , requestCount = 0
      , showSpinner = False
      }
    , Cmd.none
    )

