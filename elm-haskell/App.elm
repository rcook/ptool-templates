{%- set imports = [
    "{}.Util exposing (dropTrailingPathSeparator)".format(module_name),
    "Html exposing (Html, button, div, img, text)",
    "Html.Attributes exposing (src)",
    "Html.Events exposing (onClick)",
    "Http exposing (Error, get, send)",
    "Json.Decode exposing (Decoder, at, list, string)"
    ] -%}
{{elm_copyright}}

module App exposing (main)

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

---- TYPES ----


type alias Email =
    String


type alias Flags =
    { logoPath : String
    , apiRootUrl : String
    }



---- MODEL ----


type alias Model =
    { message : String
    , logoPath : String
    , apiRootUrl : String
    , usersResponse : Maybe (List Email)
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { message = "{{project_name}} is working!"
      , logoPath = flags.logoPath
      , apiRootUrl = dropTrailingPathSeparator flags.apiRootUrl
      , usersResponse = Nothing
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp
    | GetUsers
    | UsersResponse (Result Error (List Email))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GetUsers ->
            ( model, getUsers model )

        UsersResponse (Ok emails) ->
            ( { model | usersResponse = Just emails }, Cmd.none )

        UsersResponse (Err e) ->
            ( { model | message = toString e }, Cmd.none )



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
    case model.usersResponse of
        Nothing ->
            div [] [ text "(not loaded)" ]

        Just emails ->
            div [] [ text (toString emails) ]



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
    send UsersResponse <| get (model.apiRootUrl ++ "/users") decodeEmails


decodeEmails : Decoder (List Email)
decodeEmails =
    list decodeEmail


decodeEmail : Decoder Email
decodeEmail =
    at [ "email" ] string
