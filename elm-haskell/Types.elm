{{elm_copyright}}

module {{module_name}}.Types
    exposing
        ( Age
        , Email
        , Flags
        , User
        )

import Date exposing (Date)


type alias Flags =
    { logoPath : String
    , apiRootUrl : String
    }


type alias Age =
    Int


type alias Email =
    String


type alias User =
    { email : Email
    , age : Age
    , name : String
    , registrationDate : Date
    }

