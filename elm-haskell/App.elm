{{elm_copyright}}

module App exposing (main)

import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http exposing (Error, get, send)
import Json.Decode exposing (Decoder, at, list, string)


---- ALIASES ----


type alias Email =
    String



---- MODEL ----


type alias Model =
    { message : String
    , logo : String
    , usersResponse : Maybe (List Email)
    }


init : String -> ( Model, Cmd Msg )
init path =
    ( { message = "{{project_name}} is working!"
      , logo = path
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
            ( model, getUsers )

        UsersResponse (Ok emails) ->
            ( { model | usersResponse = Just emails }, Cmd.none )

        UsersResponse (Err e) ->
            ( { model | message = toString e }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logo ] []
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


main : Program String Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }



---- DECODERS ----


getUsers : Cmd Msg
getUsers =
    send UsersResponse <| get "http://localhost:8081/users" decodeEmails


decodeEmails : Decoder (List Email)
decodeEmails =
    list decodeEmail


decodeEmail : Decoder Email
decodeEmail =
    at [ "email" ] string
