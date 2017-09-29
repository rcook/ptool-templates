{%- set imports = [
    "{}.Codegen exposing (User, Widget, getUsers, getWidgets)".format(module_name),
    "{}.Model exposing (Model, decrementRequestCount, incrementRequestCount, initModel)".format(module_name),
    "{}.Msg exposing (Msg(..))".format(module_name),
    "{}.Types exposing (Flags)".format(module_name),
    "{}.Util exposing (dateString)".format(module_name),
    "{}.View.Util exposing (Part, requestButton, wrappedView)".format(module_name),
    "Html exposing (Attribute, Html, div, img, li, text, ul)",
    "Html.Attributes exposing (src, style)",
    "Html.Events exposing (onClick)",
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
            getUsers model.apiRootUrl
                |> sendRequest
                |> Cmd.map UsersResponse
                |> incrementRequestCount { model | users = Loading }

        UsersResponse response ->
            ( decrementRequestCount { model | users = response }, Cmd.none )

        ClearUsers ->
            ( { model | users = NotAsked }, Cmd.none )

        GetWidgets ->
            getWidgets model.apiRootUrl
                |> sendRequest
                |> Cmd.map WidgetsResponse
                |> incrementRequestCount { model | widgets = Loading }

        WidgetsResponse response ->
            ( decrementRequestCount { model | widgets = response }, Cmd.none )

        ClearWidgets ->
            ( { model | widgets = NotAsked }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    wrappedView model <|
        div [] <|
            List.concat
                [ [ img [ src model.logoPath ] []
                  , div [] [ text model.message ]
                  , div [] [ text <| "Active requests: " ++ toString model.requestCount ]
                  , requestButton model [ onClick GetUsers ] [ text "Get users" ]
                  , requestButton model [ onClick GetWidgets ] [ text "Get widgets" ]
                  ]
                , usersPart model
                , widgetsPart model
                ]


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
            [ ul [ panelStyle ] (List.map (\user -> li [] [ userView user ]) users)
            , requestButton model [ onClick ClearUsers ] [ text "Clear users" ]
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


widgetsPart : Model -> Part Msg
widgetsPart model =
    case model.widgets of
        NotAsked ->
            [ div [] [ text "(not asked)" ] ]

        Loading ->
            [ div [] [ text "(loading)" ] ]

        Failure e ->
            [ div [] [ text <| "Error: " ++ toString e ] ]

        Success widgets ->
            [ ul [ panelStyle ] (List.map (\widget -> li [] [ widgetView widget ]) widgets)
            , requestButton model [ onClick ClearWidgets ] [ text "Clear widgets" ]
            ]


widgetView : Widget -> Html msg
widgetView widget =
    div []
        [ text widget.name
        , ul []
            [ li [] [ text <| "Description: " ++ widget.description ]
            ]
        ]


panelStyle : Attribute msg
panelStyle =
    style
        [ ( "background-color", "silver" )
        , ( "padding", "0.5em" )
        , ( "text-align", "left" )
        , ( "font-size", "50%" )
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = initModel
        , update = update
        , subscriptions = \_ -> Sub.none
        }

