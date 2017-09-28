{%- set imports = [
    "{}.Decode exposing (users)".format(module_name),
    "{}.Types exposing (Flags, User)".format(module_name),
    "{}.Util exposing (dropTrailingPathSeparator)".format(module_name),
    "Html exposing (Html, button, div, img, li, text, ul)",
    "Html.Attributes exposing (src)",
    "Html.Events exposing (onClick)",
    "Http exposing (Error, get, send)",
    "RemoteData exposing (RemoteData(..), WebData, sendRequest)"
    ] -%}
{{elm_copyright}}

module App exposing (main)

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

---- MODEL ----


type alias Model =
    { message : String
    , logoPath : String
    , apiRootUrl : String
    , users : WebData (List User)
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { message = "{{project_name}} is working!"
      , logoPath = flags.logoPath
      , apiRootUrl = dropTrailingPathSeparator flags.apiRootUrl
      , users = NotAsked
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp
    | GetUsers
    | UsersResponse (WebData (List User))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GetUsers ->
            ( model, getUsers model )

        UsersResponse response ->
            ( { model | users = response }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logoPath ] []
        , div [] [ text model.message ]
        , button [ onClick GetUsers ] [ text "Get users" ]
        , usersView model
        ]


usersView : Model -> Html msg
usersView model =
    case model.users of
        NotAsked ->
            div [] [ text "(not asked)" ]

        Loading ->
            div [] [ text "(loading)" ]

        Failure e ->
            div [] [ text <| "Error: " ++ toString e ]

        Success users ->
            ul [] (List.map (\user -> li [] [ userView user ]) users)


userView : User -> Html msg
userView user =
    ul []
        [ li [] [ text <| "E-mail: " ++ user.email ]
        , li [] [ text <| "Age: " ++ toString user.age ]
        , li [] [ text <| "Name: " ++ user.name ]
        , li [] [ text <| "Registration date: " ++ toString user.registrationDate ]
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }



---- DECODERS ----


getUsers : Model -> Cmd Msg
getUsers model =
    get (model.apiRootUrl ++ "/users") users
        |> sendRequest
        |> Cmd.map UsersResponse

