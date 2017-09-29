{%- set imports = [
    "{}.Msg exposing (Msg(..))".format(module_name),
    "{}.Types exposing (Flags, User)".format(module_name),
    "{}.Util exposing (dropTrailingPathSeparator)".format(module_name),
    "Process exposing (sleep)"
    "RemoteData exposing (RemoteData(..), WebData)",
    "Task exposing (perform)",
    "Time exposing (second)"
    ] -%}
{{elm_copyright}}

module {{module_name}}.Model
    exposing
        ( Model
        , decrementRequestCount
        , incrementRequestCount
        , initModel
        )

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


incrementRequestCount : Model -> Cmd Msg -> ( Model, Cmd Msg )
incrementRequestCount model cmd =
    if model.requestCount == 0 then
        ( { model | requestCount = model.requestCount + 1, showSpinner = False }
        , Cmd.batch [ cmd, sleep (0.5 * second) |> perform (always <| ShowSpinner) ]
        )
    else
        ( { model | requestCount = model.requestCount + 1 }, cmd )


decrementRequestCount : Model -> Model
decrementRequestCount model =
    { model | requestCount = model.requestCount - 1 }

