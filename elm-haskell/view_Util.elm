{%- set imports = [
    "{}.Model exposing (Model)".format(module_name),
    "Html exposing (Attribute, Html, button, div)",
    "Html.Attributes exposing (class, disabled, style)"
    ] -%}
{{elm_copyright}}

module {{module_name}}.View.Util
    exposing
        ( Part
        , requestButton
        , wrappedView
        )

{% for i in imports | sort -%}
import {{i}}
{% endfor %}

type alias Part msg =
    List (Html msg)


requestButton : Model -> List (Attribute msg) -> List (Html msg) -> Html msg
requestButton model attrs =
    if model.requestCount > 0 then
        button (disabled True :: attrs)
    else
        button attrs


spinnerHelper : Html msg
spinnerHelper =
    div [ class "sk-fading-circle", class "a" ] <|
        List.map
            (\i -> div [ class <| "sk-circle" ++ toString i, class "sk-circle" ] [])
            (List.range 1 12)


wrappedView : Model -> Html msg -> Html msg
wrappedView model html =
    if model.requestCount > 0 then
        div
            [ style [ ( "position", "relative" ) ] ]
            [ div
                [ style [ ( "position", "absolute" ), ( "top", "50%" ), ( "left", "50%" ), ( "transform", "(-50%, -50%)" ) ] ]
                (if model.showSpinner then
                    [ spinnerHelper ]
                 else
                    []
                )
            , div
                [ style [ ( "opacity", "0.5" ), ( "pointer-events", "none !important" ) ] ]
                [ html ]
            ]
    else
        html
