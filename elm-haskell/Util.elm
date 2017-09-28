{{elm_copyright}}

module {{module_name}}.Util
    exposing
        ( dropTrailingPathSeparator
        , hasTrailingPathSeparator
        )


hasTrailingPathSeparator : String -> Bool
hasTrailingPathSeparator =
    String.endsWith "/"


dropTrailingPathSeparator : String -> String
dropTrailingPathSeparator s =
    if hasTrailingPathSeparator s then
        let
            n =
                String.length s
        in
        String.slice 0 (n - 1) s
    else
        s

