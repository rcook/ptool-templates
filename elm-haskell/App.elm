{%- set imports = [
    "{}.Decode exposing (users)".format(module_name),
    "{}.Model exposing (Model, decrementRequestCount, incrementRequestCount, initModel)".format(module_name),
    "{}.Msg exposing (Msg(..))".format(module_name),
    "{}.Types exposing (Flags, User)".format(module_name),
    "{}.View.Util exposing (Part, requestButton, wrappedView)".format(module_name),
    "Date exposing (Date)",
    "Date.Extra.Config.Config_en_us exposing (config)",
    "Date.Extra.Format as Format exposing (format)",
    "Html exposing (Attribute, Html, div, img, li, text, ul)",
    "Html.Attributes exposing (src, style)",
    "Html.Events exposing (onClick)",
    "Http exposing (Error, get, send)",
    "RemoteData exposing (RemoteData(..), sendRequest)"
    ] -%}
{{elm_copyright}}

module App exposing (main)

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowSpinner ->
            ( { model | showSpinner = model.requestCount > 0 }, Cmd.none )

        GetUsers ->
            getUsers { model | users = Loading }

        ClearUsers ->
            ( { model | users = NotAsked }, Cmd.none )

        UsersResponse response ->
            ( decrementRequestCount { model | users = response }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    wrappedView model <|
        div [] <|
            List.append
                [ img [ src model.logoPath ] []
                , div [] [ text model.message ]
                , div [] [ text <| "Active requests: " ++ toString model.requestCount ]
                , requestButton model [ onClick GetUsers ] [ text "Get users" ]
                ]
            <|
                usersPart model


usersPart : Model -> Part Msg
usersPart model =
    case model.users of
        NotAsked ->
            [ div [] [ text "(not asked)" ] ]

        Loading ->
            [ div [] [ text "(loading)" ] ]

        Failure e ->
            [ div [] [ text <| "Error: " ++ toString e ] ]

        Success users ->
            [ requestButton model [ onClick ClearUsers ] [ text "Clear users" ]
            , ul [ usersStyle ] (List.map (\user -> li [] [ userView user ]) users)
            ]


usersStyle : Attribute msg
usersStyle =
    style
        [ ( "background-color", "silver" )
        , ( "padding", "0.5em" )
        , ( "text-align", "left" )
        , ( "font-size", "50%" )
        ]


userView : User -> Html msg
userView user =
    div []
        [ text user.name
        , ul []
            [ li [] [ text <| "E-mail: " ++ user.email ]
            , li [] [ text <| "Age: " ++ toString user.age ]
            , li [] [ text <| "Registration date: " ++ dateString user.registrationDate ]
            ]
        ]


dateString : Date -> String
dateString date =
    format config
        config.format.date
        date



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = initModel
        , update = update
        , subscriptions = \_ -> Sub.none
        }



---- API ----


getUsers : Model -> ( Model, Cmd Msg )
getUsers model =
    get (model.apiRootUrl ++ "/users") users
        |> sendRequest
        |> Cmd.map UsersResponse
        |> incrementRequestCount model

