{%-
    set imported_module_names =
        (["Types"] | map("child_module_name", "App") | list) +
        ["Control.Concurrent", "Network.Wai", "Network.Wai.Middleware.Cors"]
-%}
{{hs_copyright}}
{-# LANGUAGE OverloadedStrings #-}

module {{module_name}}App.Util
    ( apiCorsMiddleware
    , delayMiddleware
    ) where

{% for m in imported_module_names | sort -%}
import           {{m}}
{% endfor %}
apiCorsMiddleware :: Middleware
apiCorsMiddleware = cors $ const (Just apiResourcePolicy)
    where apiResourcePolicy = simpleCorsResourcePolicy
                                { corsRequestHeaders = "Authorization" : simpleHeaders
                                }

-- type Middleware = Application -> Request -> (Response -> IO ResponseReceived) -> IO ResponseReceived
delayMiddleware :: Milliseconds -> Middleware
delayMiddleware (Milliseconds ms) app req respond =
    if ms == 0
    then app req respond
    else do
        putStrLn $ "Sleep for " ++ show ms ++ " ms..."
        threadDelay $ ms * 1000
        putStrLn "Finished sleep"
        app req respond
