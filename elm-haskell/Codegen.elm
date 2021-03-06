-- Generated code
module {{module_name}}.Codegen exposing (User, Widget, getAlbert, getIsaac, getUsers, getWidgets)

import Date exposing (Date)
import {{module_name}}.Decode exposing (decodeDate)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Json.Encode
import Http
import String


type alias User =
    { name : String
    , age : Int
    , email : String
    , registrationDate : Date
    }

decodeUser : Decoder User
decodeUser =
    decode User
        |> required "name" string
        |> required "age" int
        |> required "email" string
        |> required "registrationDate" decodeDate

encodeUser : User -> Json.Encode.Value
encodeUser x =
    Json.Encode.object
        [ ( "name", Json.Encode.string x.name )
        , ( "age", Json.Encode.int x.age )
        , ( "email", Json.Encode.string x.email )
        , ( "registrationDate", (Json.Encode.string << toString) x.registrationDate )
        ]

type alias Widget =
    { name : String
    , description : String
    }

decodeWidget : Decoder Widget
decodeWidget =
    decode Widget
        |> required "name" string
        |> required "description" string

encodeWidget : Widget -> Json.Encode.Value
encodeWidget x =
    Json.Encode.object
        [ ( "name", Json.Encode.string x.name )
        , ( "description", Json.Encode.string x.description )
        ]

getUsers : String -> Http.Request (List (User))
getUsers urlBase =
    Http.request
        { method =
            "GET"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "users"
                ]
        , body =
            Http.emptyBody
        , expect =
            Http.expectJson (list decodeUser)
        , timeout =
            Nothing
        , withCredentials =
            False
        }

getAlbert : String -> Http.Request (User)
getAlbert urlBase =
    Http.request
        { method =
            "GET"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "albert"
                ]
        , body =
            Http.emptyBody
        , expect =
            Http.expectJson decodeUser
        , timeout =
            Nothing
        , withCredentials =
            False
        }

getIsaac : String -> Http.Request (User)
getIsaac urlBase =
    Http.request
        { method =
            "GET"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "isaac"
                ]
        , body =
            Http.emptyBody
        , expect =
            Http.expectJson decodeUser
        , timeout =
            Nothing
        , withCredentials =
            False
        }

getWidgets : String -> Http.Request (List (Widget))
getWidgets urlBase =
    Http.request
        { method =
            "GET"
        , headers =
            []
        , url =
            String.join "/"
                [ urlBase
                , "widgets"
                ]
        , body =
            Http.emptyBody
        , expect =
            Http.expectJson (list decodeWidget)
        , timeout =
            Nothing
        , withCredentials =
            False
        }

